extension TencentCloud {
    public struct API<T: Codable, R: TencentCloudAPIResponse> {
        public typealias Payload = T
        public typealias Response = R
        public let endpoint: TencentCloud.EndPoint
        public let region: TencentCloud.Region?
        public let action: String
        public let version: String
    }
}

extension TencentCloud.API {
    private struct ResponseWrapper<T: TencentCloudAPIResponse>: Codable {
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
                    if let response = try? TencentCloud.jsonDecoder.decode(ResponseWrapper<TencentCloud.WrappedAPIError>.self, from: data) {
                        throw response.body.error
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
