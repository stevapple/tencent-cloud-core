extension TencentCloud.CVM {
    public struct DescribeRegions: TencentCloudServiceAPI, TencentCloudGlobalAPI {
        public static var endpoint: TencentCloud.Endpoint { TencentCloud.CVM.endpoint }
        public static var version: String { "2017-03-12" }

        public let endpoint: TencentCloud.Endpoint
        public init(endpoint: TencentCloud.Endpoint) {
            self.endpoint = endpoint
        }
    }

    public var DescribeRegions: Self.DescribeRegions { .init(endpoint: endpoint) }
}

extension TencentCloud.CVM.DescribeRegions {
    public struct RequestPayload: Codable {}

    public struct Response: TencentCloudAPIResponse {
        public let count: Int
        public let regions: [TencentCloud.CVM.RegionInfo]
        public let requestId: UUID

        enum CodingKeys: String, CodingKey {
            case count = "TotalCount"
            case regions = "RegionSet"
            case requestId = "RequestId"
        }
    }
}
