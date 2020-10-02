public protocol TencentCloudService {
    static var name: String { get }

    var endpoint: TencentCloud.Endpoint { get }
    init(endpoint: TencentCloud.Endpoint)
}

public extension TencentCloudService {
    static var endpoint: TencentCloud.Endpoint { .init(of: name) }

    init(region: TencentCloud.Region? = nil, credential: TencentCloud.Credential? = nil) {
        self.init(endpoint: .init(of: Self.name, region: region, credential: credential))
    }
}
