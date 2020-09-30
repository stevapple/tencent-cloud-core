import TencentCloudCore

extension TencentCloud {
    public struct EndPoint {
        private static let domain: String = "tencentcloudapi.com"
        let service: String
        let region: Region?
        let credential: Credential
        let token: String?
        
        public var hostname: String {
            if let region = region {
                return "\(service).\(region).\(Self.domain)"
            } else {
                return "\(service).\(Self.domain)"
            }
        }

        public init?(of product: String, region: Region? = nil, credential: Credential? = nil, token: String? = nil) {
            self.service = product
            self.region = region
            guard let newCredential = credential ?? TencentCloud.credential else {
                return nil
            }
            self.credential = newCredential
            self.token = token
        }

        public init?(_ hostname: String, credential: Credential? = nil, token: String? = nil) {
            guard hostname.hasSuffix(".\(Self.domain)") else { return nil }
            let arr = hostname.dropLast(Self.domain.count + 1).split(separator: ".")
            switch arr.count {
            case 1:
                self.init(of: .init(arr[0]), credential: credential, token: token)
            case 2:
                self.init(of: .init(arr[0]), region: Region(rawValue: .init(arr[1])), credential: credential, token: token)
            default:
                return nil
            }
        }
    }
}

extension TencentCloud {
    public static var credential: Credential?
}
