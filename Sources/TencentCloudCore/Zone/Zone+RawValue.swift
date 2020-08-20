extension TencentCloud.Zone: RawRepresentable, CustomStringConvertible {
    public typealias RawValue = String

    public var rawValue: String {
        "\(self.region)-\(self.number)"
    }

    public var description: String {
        self.rawValue
    }

    public init?(rawValue: String) {
        guard let (optionalRegion, number) = Self.parse(rawValue: rawValue),
            let region = optionalRegion
        else {
            return nil
        }
        self.init(region: region, number: number)
    }
}
