public protocol TencentCloudAPIResponse: Codable {
    var requestId: String { get }
}

extension TencentCloud {
    internal struct WrappedAPIError: TencentCloudAPIResponse {
        public let error: TencentCloud.APIError
        public let requestId: String

        enum CodingKeys: String, CodingKey {
            case error = "Error"
            case requestId = "RequestId"
        }
    }
}