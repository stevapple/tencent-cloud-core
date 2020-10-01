internal protocol TencentCloudService: ExposingDefault {
    static var name: String { get }
    static var endpoint: TencentCloud.Endpoint { get }

    var endpoint: TencentCloud.Endpoint { get }
    init(endpoint: TencentCloud.Endpoint)
}

extension TencentCloudService {
    internal static var `default`: Self { .init(endpoint: endpoint) }
    public static var endpoint: TencentCloud.Endpoint { .init(of: name) }

    public init(region: TencentCloud.Region? = nil, credential: TencentCloud.Credential? = nil) {
        self.init(endpoint: .init(of: Self.name, region: region, credential: credential))
    }
}
