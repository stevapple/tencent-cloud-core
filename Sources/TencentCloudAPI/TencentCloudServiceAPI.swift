protocol TencentCloudServiceAPI: TencentCloudAPI, ExposingDefault {
    static var endpoint: TencentCloud.Endpoint { get }
    init(endpoint: TencentCloud.Endpoint)
}

extension TencentCloudServiceAPI {
    internal static var `default`: Self {
        .init(endpoint: endpoint)
    }

    public static func invoke(with payload: RequestPayload, region: TencentCloud.Region? = nil, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.default.invoke(with: payload, region: region, completionHandler: completionHandler)
    }
}
