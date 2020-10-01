public struct RegionInfo: Decodable {
    public let isAvailable: Bool
    public let region: TencentCloud.Region
    public let name: String

    enum CodingKeys: String, CodingKey {
        case state = "RegionState"
        case region = "Region"
        case name = "RegionName"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let state = try container.decode(String.self, forKey: .state)
        switch state {
        case "AVAILABLE": self.isAvailable = true
        case "UNAVAILABLE": self.isAvailable = false
        default:
            throw DecodingError.dataCorruptedError(forKey: .state, in: container, debugDescription: "Expected RegionState to be AVAILABLE or UNAVAILABLE, but `\(state)` does not forfill format")
        }

        self.region = try container.decode(TencentCloud.Region.self, forKey: .region)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
