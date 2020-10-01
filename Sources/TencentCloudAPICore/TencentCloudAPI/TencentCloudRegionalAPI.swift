public protocol TencentCloudRegionalAPI: TencentCloudAPI {}

extension TencentCloudRegionalAPI {
    public func invoke(with payload: RequestPayload, region: TencentCloud.Region, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.invoke(with: payload, region: region as TencentCloud.Region?, completionHandler: completionHandler)
    }
}
