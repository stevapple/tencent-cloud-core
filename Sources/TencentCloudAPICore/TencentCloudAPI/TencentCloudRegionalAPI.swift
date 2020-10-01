public protocol TencentCloudRegionalAPI: TencentCloudAPI {}

extension TencentCloudRegionalAPI {
    public func invoke(with payload: RequestPayload, region: TencentCloud.Region, language: TencentCloud.Language? = .default, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.invoke(with: payload, region: region as TencentCloud.Region?, language: language, completionHandler: completionHandler)
    }
}
