extension TencentCloud.CVM {
    public struct DescribeZones: TencentCloudServiceAPI, TencentCloudRegionalAPI {
        public static var endpoint: TencentCloud.Endpoint { TencentCloud.CVM.endpoint }
        public static var version: String { "2017-03-12" }

        public let endpoint: TencentCloud.Endpoint
        public init(endpoint: TencentCloud.Endpoint) {
            self.endpoint = endpoint
        }
    }

    public var DescribeZones: Self.DescribeZones { .init(endpoint: endpoint) }
}

extension TencentCloud.CVM.DescribeZones {
    public struct RequestPayload: Codable {}

    public struct Response: TencentCloudAPIResponse {
        public let count: Int
        public let zones: [ZoneInfo]
        public let requestId: UUID

        enum CodingKeys: String, CodingKey {
            case count = "TotalCount"
            case zones = "ZoneSet"
            case requestId = "RequestId"
        }
    }
}
