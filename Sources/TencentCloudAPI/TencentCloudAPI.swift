extension TencentCloud {
    public struct API<T: Codable, R: TencentCloudAPIResponse> {
        public typealias Payload = T
        public typealias Response = R
        public let endpoint: EndPoint
        public let region: Region?
        public let action: String
        public let version: String

        public init(endpoint: EndPoint, action: String, version: String, region: Region? = nil) {
            self.endpoint = endpoint
            self.action = action
            self.version = version
            self.region = region
        }
    }
}

extension TencentCloud.API {
    private struct ResponseWrapper<T: TencentCloudAPIResponse>: Decodable {
        let body: T

        enum CodingKeys: String, CodingKey {
            case body = "Response"
        }
    }

    public func invoke(with payload: Payload, completionHandler: @escaping (Response?, Error?) -> Void) throws {
        let request = try urlRequest(with: payload)
        let dataTask = TencentCloud.urlSession.dataTask(with: request) { (data, _, error) in
            do {
                if let error = error { throw error }
                if let data = data {
                    if let response = try? TencentCloud.jsonDecoder.decode(ResponseWrapper<TencentCloud.APIError>.self, from: data) {
                        throw response.body
                    }
                    let response = try TencentCloud.jsonDecoder.decode(ResponseWrapper<Response>.self, from: data)
                    return completionHandler(response.body, nil)
                }
            } catch let error {
                return completionHandler(nil, error)
            }
            fatalError("Unhandled response cases")
        }
        dataTask.resume()
    }
}
