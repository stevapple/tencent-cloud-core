extension TencentCloud.CVM {
    public struct RegionInfo: Decodable {
        @Availability public var isAvailable: Bool
        public let region: TencentCloud.Region
        public let name: String

        enum CodingKeys: String, CodingKey {
            case isAvailable = "RegionState"
            case region = "Region"
            case name = "RegionName"
        }
    }
}
