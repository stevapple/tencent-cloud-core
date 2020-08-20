// List all available zones using tccli:
//   $ tccli cvm DescribeZones --region <Region>

/// A `struct` representing a Tencent Cloud zone.
extension TencentCloud {
    public struct Zone: RawRepresentable, CustomStringConvertible, Equatable, Hashable {
        public typealias RawValue = String

        public var rawValue: String {
            "\(self.region)-\(self.number)"
        }

        public var description: String {
            self.rawValue
        }

        public init?(rawValue: String) {
            guard let (region, number) = Self.parse(rawValue: rawValue) else {
                return nil
            }
            self.region = region
            self.number = number
        }

        private static func parse(rawValue: String) -> (Region, UInt8)? {
            let components = rawValue.split(separator: "-")
            guard components.count > 2, let number = UInt8(components.last!) else {
                return nil
            }

            let region = Region(rawValue: components.dropLast().joined(separator: "-"))!
            return (region, number)
        }

        public let region: Region

        public let number: UInt8
    }
}

extension TencentCloud.Zone: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let zone = try container.decode(String.self)
        guard let (region, number) = Self.parse(rawValue: zone) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription:
                "Expected zone format like `ap-shanghai-3` or `ap-shenzhen-fsi-1`, but `\(zone)` does not forfill format")
        }
        self.region = region
        self.number = number
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}
