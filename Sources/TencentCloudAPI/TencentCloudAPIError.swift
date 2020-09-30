extension TencentCloud {
    public struct APIError: Error, TencentCloudAPIResponse {
        public let requestId: UUID
        public let code: String
        public let message: String

        enum CodingKeys: String, CodingKey {
            case error = "Error"
            case requestId = "RequestId"
        }
        enum ErrorCodingKeys: String, CodingKey {
            case code = "Code"
            case message = "Message"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            requestId = try container.decode(UUID.self, forKey: .requestId)

            let errorContainer = try container.nestedContainer(keyedBy: ErrorCodingKeys.self, forKey: .error)
            code = try errorContainer.decode(String.self, forKey: .code)
            message = try errorContainer.decode(String.self, forKey: .message)
        }
    }
}