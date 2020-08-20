/// A `struct` representing a Tencent Cloud credential.
extension TencentCloud {
    public struct Credential {
        let secretId: String
        let secretKey: String
        let sessionToken: String?

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
