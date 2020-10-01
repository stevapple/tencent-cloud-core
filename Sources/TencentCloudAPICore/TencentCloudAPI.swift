public protocol TencentCloudAPI {
    associatedtype RequestPayload: Codable
    associatedtype Response: TencentCloudAPIResponse
    static var endpoint: TencentCloud.Endpoint { get }
    static var action: String { get }
    static var version: String { get }
}

extension TencentCloud {
    fileprivate struct APIResponse<T: TencentCloudAPIResponse>: Decodable {
        let body: T

        enum CodingKeys: String, CodingKey {
            case body = "Response"
        }
    }
}

extension TencentCloudAPI {
    public static var action: String { "\(Self.self)" }

    public static func invoke(with payload: RequestPayload, region: TencentCloud.Region? = nil, completionHandler: @escaping (Response?, Error?) -> Void) throws {
        let request = try urlRequest(with: payload, region: region)
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
    }
}
