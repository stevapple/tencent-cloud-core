public protocol TencentCloudServiceAPI: TencentCloudAPI {
    static var endpoint: TencentCloud.Endpoint { get }

    init(endpoint: TencentCloud.Endpoint)
}

fileprivate extension TencentCloudServiceAPI {
    static var `default`: Self { .init(endpoint: endpoint) }
}

public extension TencentCloudServiceAPI where Self: TencentCloudGlobalAPI {
    static func invoke(with payload: RequestPayload, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.default.invoke(with: payload, completionHandler: completionHandler)
    }

    static func invoke(with payload: RequestPayload, language: TencentCloud.Language, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.default.invoke(with: payload, language: language, completionHandler: completionHandler)
    }
}

public extension TencentCloudServiceAPI where Self: TencentCloudRegionalAPI {
    static func invoke(with payload: RequestPayload, region: TencentCloud.Region, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.default.invoke(with: payload, region: region, completionHandler: completionHandler)
    }

    static func invoke(with payload: RequestPayload, region: TencentCloud.Region, language: TencentCloud.Language, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.default.invoke(with: payload, region: region, language: language, completionHandler: completionHandler)
    }
}
