extension TencentCloud {
    public struct CVM: TencentCloudService {
        public static var name: String { "cvm" }

        public let endpoint: TencentCloud.Endpoint

        public init(endpoint: TencentCloud.Endpoint) {
            self.endpoint = endpoint
        }
    }
}
