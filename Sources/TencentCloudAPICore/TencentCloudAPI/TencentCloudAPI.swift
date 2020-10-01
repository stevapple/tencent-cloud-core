public protocol TencentCloudAPI {
    associatedtype RequestPayload: Codable
    associatedtype Response: TencentCloudAPIResponse

    var endpoint: TencentCloud.Endpoint { get }
    static var action: String { get }
    static var version: String { get }

    init(endpoint: TencentCloud.Endpoint)
}

extension TencentCloudAPI {
    public static var action: String { "\(Self.self)" }

    internal func invoke(with payload: RequestPayload, region: TencentCloud.Region?, completionHandler: @escaping (Response?, Error?) -> Void) {
        do {
            guard let credential = endpoint.credential ?? .default else {
                throw ClientError.noCredential
            }
            let request = try urlRequest(with: payload, region: region, credential: credential)
            let dataTask = TencentCloud.urlSession.dataTask(with: request) { data, _, error in
                do {
                    if let error = error { throw error }
                    if let data = data {
                        if let response = try? TencentCloud.jsonDecoder.decode(TencentCloud.APIResponse<TencentCloud.APIError>.self, from: data) {
                            throw response.body
                        }
                        let response = try TencentCloud.jsonDecoder.decode(TencentCloud.APIResponse<Response>.self, from: data)
                        return completionHandler(response.body, nil)
                    }
                } catch {
                    return completionHandler(nil, error)
                }
                fatalError("Unhandled response cases")
            }
            dataTask.resume()
        } catch {
            completionHandler(nil, error)
        }
    }
}

public enum ClientError: Error {
    case noCredential
}

extension TencentCloud {
    fileprivate struct APIResponse<T: TencentCloudAPIResponse>: Decodable {
        let body: T

        enum CodingKeys: String, CodingKey {
            case body = "Response"
        }
    }
}
