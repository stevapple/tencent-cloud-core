import class Foundation.ProcessInfo

private let env = ProcessInfo.processInfo.environment

extension TencentCloud {
    public struct EndPoint {
        private static let domain = "tencentcloudapi.com"
        internal let service: String
        internal let region: Region?
        internal let credential: Credential

        public var hostname: String {
            if let region = region {
                return "\(service).\(region.rawValue).\(Self.domain)"
            } else {
                return "\(service).\(Self.domain)"
            }
        }
        public var secretId: String { credential.secretId }

        public init?(of service: String, region: Region? = nil, credential: Credential? = nil) {
            self.service = service
            self.region = region
            guard let newCredential = credential ?? .default else { return nil }
            self.credential = newCredential
        }

        public init?(_ hostname: String, credential: Credential? = nil) {
            guard hostname.hasSuffix(".\(Self.domain)") else { return nil }
            let arr = hostname.dropLast(Self.domain.count + 1).split(separator: ".")
            switch arr.count {
            case 1:
                self.init(of: .init(arr[0]), credential: credential)
            case 2:
                self.init(of: .init(arr[0]), region: Region(rawValue: .init(arr[1])), credential: credential)
            default:
                return nil
            }
        }
    }
}

extension TencentCloud.Credential {
    fileprivate static var `default`: Self? {
        if let secretId = env["API_SECRET_ID"],
           let secretKey = env["API_SECRET_KEY"] {
            let token = env["API_SESSION_TOKEN"]
            return TencentCloud.Credential(secretId: secretId, secretKey: secretKey, sessionToken: token)
        }

        if let secretId = env["TENCENTCLOUD_SECRETID"],
           let secretKey = env["TENCENTCLOUD_SECRETKEY"] {
            let token = env["TENCENTCLOUD_SESSIONTOKEN"]
            return TencentCloud.Credential(secretId: secretId, secretKey: secretKey, sessionToken: token)
        }

        return nil
    }
}
