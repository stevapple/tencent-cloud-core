protocol TencentCloudServiceAPI: TencentCloudAPI, ExposingDefault {
    static var endpoint: TencentCloud.Endpoint { get }
    init(endpoint: TencentCloud.Endpoint)
}

extension TencentCloudServiceAPI {
    internal static var `default`: Self {
        .init(endpoint: endpoint)
    }
}

extension TencentCloudServiceAPI where Self: TencentCloudGlobalAPI {
    internal static func invoke(with payload: RequestPayload, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.default.invoke(with: payload, completionHandler: completionHandler)
    }
}

extension TencentCloudServiceAPI where Self: TencentCloudRegionalAPI {
    internal static func invoke(with payload: RequestPayload, region: TencentCloud.Region, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.default.invoke(with: payload, region: region, completionHandler: completionHandler)
    }
}
