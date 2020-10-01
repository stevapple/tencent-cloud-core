public protocol TencentCloudGlobalAPI: TencentCloudAPI {}

extension TencentCloudGlobalAPI {
    public func invoke(with payload: RequestPayload, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.invoke(with: payload, region: nil, completionHandler: completionHandler)
    }
}
