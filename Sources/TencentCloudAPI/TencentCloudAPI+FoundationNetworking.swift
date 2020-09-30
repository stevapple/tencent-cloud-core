import class Foundation.DateFormatter
import struct Foundation.URL
import struct Foundation.Date
import struct Foundation.Locale

#if canImport(FoundationNetworking)
import struct FoundationNetworking.URLRequest
#else
import struct Foundation.URLRequest
#endif

import Crypto

private let signAlgorithm = "TC3-HMAC-SHA256"
private let httpMethod = "POST"

extension TencentCloud {
    fileprivate static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

extension TencentCloud.API {
    internal func urlRequest(with payload: Payload, region: TencentCloud.Region?) throws -> URLRequest {
        let date = Date()
        var headers = ["Content-Type": "application/json; charset=utf-8",
                       "Host": endpoint.hostname,
                       "X-TC-Action": action,
                       "X-TC-Timestamp": Int(date.timeIntervalSince1970).description,
                       "X-TC-Version": version
        ]
        let payloadJSON = try TencentCloud.jsonEncoder.encode(payload)
        let signedHeaders = headers.sorted { $0.0 < $1.0 } .map { ($0.lowercased(), $1.lowercased()) }
        let canonicalRequest = """
        \(httpMethod)
        /
        
        \(signedHeaders.map { "\($0.0):\($0.1)\n" } .joined())
        \(signedHeaders.map { $0.0 }.joined(separator: ";"))
        \(SHA256.hash(data: payloadJSON).hexString)
        """.data(using: .utf8)!

        let credentialScope = (TencentCloud.dateFormatter.string(from: date), endpoint.service, "tc3_request")
        let toSign = """
        \(signAlgorithm)
        \(Int(date.timeIntervalSince1970))
        \(credentialScope.0)/\(credentialScope.1)/\(credentialScope.2)
        \(SHA256.hash(data: canonicalRequest).hexString)
        """.data(using: .utf8)!

        let secretDate = HMAC<SHA256>.authenticationCode(
            for: credentialScope.0.data(using: .utf8)!,
            using: .init(data: "TC3\(endpoint.credential.secretKey)".data(using: .utf8)!)
        ).data
        let secretService = HMAC<SHA256>.authenticationCode(
            for: credentialScope.1.data(using: .utf8)!,
            using: .init(data: secretDate)
        ).data
        let secretSigning = HMAC<SHA256>.authenticationCode(
            for: credentialScope.2.data(using: .utf8)!,
            using: .init(data: secretService)
        ).data
        let signature = HMAC<SHA256>.authenticationCode(
            for: toSign,
            using: .init(data: secretSigning)
        ).hexString

        let params = [
            ("Credential", "\(endpoint.credential.secretId)/\(credentialScope.0)/\(credentialScope.1)/\(credentialScope.2)"),
            ("SignedHeaders", signedHeaders.map { $0.0 }.joined(separator: ";")),
            ("Signature", signature),
        ]
        let authorization = "\(signAlgorithm) \(params.map { "\($0.0)=\($0.1)" } .joined(separator: ", "))"

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
        request.httpMethod = httpMethod
        request.httpBody = payloadJSON
        return request
    }
}
