/// A `struct` representing a Tencent Cloud credential.
extension TencentCloud {
    public struct Credential: Codable {
        public let secretId: String
        public let secretKey: String
        public let sessionToken: String?

        enum CodingKeys: String, CodingKey {
            case secretId = "SecretId"
            case secretKey = "SecretKey"
            case sessionToken = "SessionToken"
        }

        public init(secretId: String,
                    secretKey: String,
                    sessionToken: String? = nil)
        {
            self.secretId = secretId
            self.secretKey = secretKey
            self.sessionToken = sessionToken
        }
    }
}
