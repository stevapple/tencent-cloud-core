extension TencentCloud {
    public struct APIError: Error, Codable {
        public let code: String
        public let message: String

        enum CodingKeys: String, CodingKey {
            case code = "Code"
            case message = "Message"
        }
    }
}