extension TencentCloud.Region: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let regionString = try container.decode(String.self)
        guard let (area, name, type) = Self.parse(rawValue: regionString) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription:
                "Expected zone format like `ap-shanghai` or `ap-shenzhen-fsi`, but `\(regionString)` does not forfill format")
        }
        self.init(area: area, name: name, type: type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}
