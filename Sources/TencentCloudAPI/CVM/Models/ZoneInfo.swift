extension TencentCloud.CVM {
    public struct ZoneInfo: Decodable {
        public let isAvailable: Bool
        public let id: UInt
        public let zone: TencentCloud.Zone
        public let name: String

        enum CodingKeys: String, CodingKey {
            case state = "ZoneState"
            case id = "ZoneId"
            case zone = "Zone"
            case name = "ZoneName"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let state = try container.decode(String.self, forKey: .state)
            switch state {
            case "AVAILABLE": self.isAvailable = true
            case "UNAVAILABLE": self.isAvailable = false
            default:
                throw DecodingError.dataCorruptedError(forKey: .state, in: container, debugDescription: "Expected ZoneState to be AVAILABLE or UNAVAILABLE, but `\(state)` does not forfill format")
            }

            let idString = try container.decode(String.self, forKey: .id)
            guard let id = UInt(idString) else {
                throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "Expected ZoneId to be an integer, but `\(idString)` does not forfill format")
            }
            self.id = id

            self.zone = try container.decode(TencentCloud.Zone.self, forKey: .zone)
            self.name = try container.decode(String.self, forKey: .name)
        }
    }
}
