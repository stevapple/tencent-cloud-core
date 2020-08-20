extension TencentCloud.Zone: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let zone = try container.decode(String.self)
        guard let (optionalRegion, number) = Self.parse(rawValue: zone),
            let region = optionalRegion
        else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription:
                "Expected zone format like `ap-shanghai-3` or `ap-shenzhen-fsi-1`, but `\(zone)` does not forfill format")
        }
        self.init(region: region, number: number)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
