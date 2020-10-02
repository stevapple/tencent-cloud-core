extension TencentCloud.CVM {
    public struct ZoneInfo: Decodable {
        @Availability public var isAvailable: Bool
        @IdentityNumber public var id: UInt
        public let zone: TencentCloud.Zone
        public let name: String

        enum CodingKeys: String, CodingKey {
            case isAvailable = "ZoneState"
            case id = "ZoneId"
            case zone = "Zone"
            case name = "ZoneName"
        }
    }
}
