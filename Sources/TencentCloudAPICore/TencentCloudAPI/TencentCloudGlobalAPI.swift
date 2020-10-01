public protocol TencentCloudGlobalAPI: TencentCloudAPI {}

extension TencentCloudGlobalAPI {
    public func invoke(with payload: RequestPayload, language: TencentCloud.Language? = .default, completionHandler: @escaping (Response?, Error?) -> Void) {
        self.invoke(with: payload, region: nil, language: language, completionHandler: completionHandler)
    }
}
