
import class Foundation.JSONEncoder
import class Foundation.JSONDecoder
import class Foundation.DateFormatter
import struct Foundation.URL
import struct Foundation.Date
import struct Foundation.Locale
import protocol Foundation.DataProtocol

#if canImport(FoundationNetworking)
import class FoundationNetworking.URLSession
import struct FoundationNetworking.URLRequest
#else
import class Foundation.URLSession
import struct Foundation.URLRequest
#endif

import Crypto
import TencentCloudCore

extension TencentCloud {
    private static let urlSession = URLSession.shared
    private static let jsonEncoder = JSONEncoder()
    private static let jsonDecoder = JSONDecoder()
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    struct API<T: Codable, R: Codable> {
        typealias Payload = T
        typealias Response = R
        public let endpoint: TencentCloud.EndPoint
        public let region: TencentCloud.Region?
        public let action: String
        public let version: String
    }
}

extension TencentCloud.API {
    private func urlRequest(with payload: Payload) throws -> URLRequest {
        let date = Date()
        var headers = ["Content-Type": "application/json; charset=utf-8",
                       "Host": endpoint.hostname,
                       "X-TC-Action": action,
                       "X-TC-Timestamp": Int(date.timeIntervalSince1970).description,
                       "X-TC-Version": version
        ]
        let payloadJSON = try TencentCloud.jsonEncoder.encode(payload)
        let signedHeaders = headers.map { (key, _) in key.lowercased() } .joined(separator: ";")
        let canonicalRequest = """
        POST
        /
        
        \(headers.map { (key, value) in "\(key.lowercased()):\(value.lowercased())\n" } .joined())
        \(signedHeaders)
        \(SHA256.hash(data: payloadJSON).hexString)
        """.data(using: .utf8)!

        let credentialScope = "\(TencentCloud.dateFormatter.string(from: date))/\(endpoint.service)/tc3_request"
        let toSign = """
        TC3-HMAC-SHA256
        \(Int(date.timeIntervalSince1970))
        \(credentialScope)
        \(SHA256.hash(data: canonicalRequest).hexString)
        """.data(using: .utf8)!

        let secretDate = HMAC<SHA256>.authenticationCode(
            for: TencentCloud.dateFormatter.string(from: date).data(using: .utf8)!,
            using: .init(data: "TC3\(endpoint.credential.secretKey)".data(using: .utf8)!)
        ).data
        let secretService = HMAC<SHA256>.authenticationCode(
            for: endpoint.service.data(using: .utf8)!,
            using: .init(data: secretDate)
        ).data
        let secretSigning = HMAC<SHA256>.authenticationCode(
            for: "tc3_request".data(using: .utf8)!,
            using: .init(data: secretService)
        ).data
        let signature = HMAC<SHA256>.authenticationCode(
            for: toSign,
            using: .init(data: secretSigning)
        ).hexString
        
        let params = [
            "Credential": "\(endpoint.credential.secretId)/\(credentialScope)",
            "SignedHeaders": signedHeaders,
            "Signature": signature
        ]
        let authorization = "TC3-HMAC-SHA256 \(params.map { (key, value) in "\(key)=\(value)" } .joined(separator: ", "))"

        headers.updateValue(authorization, forKey: "Authorization")
        if let token = endpoint.credential.sessionToken {
            headers.updateValue(token, forKey: "X-TC-Token")
        }
        if let region = region {
            headers.updateValue(region.rawValue, forKey: "X-TC-Region")
        }
        headers.removeValue(forKey: "Host")

        var request = URLRequest(url: URL(string: "https://\(endpoint.hostname)/")!)
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpMethod = "POST"
        request.httpBody = payloadJSON
        return request
    }

    public func invoke(with payload: Payload, completionHandler: @escaping (Response?, Error?) -> Void) throws {
        let request = try urlRequest(with: payload)
        let dataTask = TencentCloud.urlSession.dataTask(with: request) { (data, urlResponse, error) in
            do {
                if let error = error {
                    throw error
                }
                if let data = data {
                    let response = try TencentCloud.jsonDecoder.decode(Response.self, from: data)
                    completionHandler(response, nil)
                }
            } catch let error {
                completionHandler(nil, error)
            }
        }
        dataTask.resume()
    }
}
