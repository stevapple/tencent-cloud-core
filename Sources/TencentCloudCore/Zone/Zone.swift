// List all available zones using tccli:
//   $ tccli cvm DescribeZones --region <Region>

/// A `struct` representing a Tencent Cloud zone.
extension TencentCloud {
    public struct Zone: Equatable, Hashable {
        public let region: Region

        public let number: UInt8

        internal static func parse(rawValue: String) -> (Region?, UInt8)? {
            let components = rawValue.split(separator: "-")
            guard components.count > 2, let number = UInt8(components.last!) else {
                return nil
            }

            let region = Region(rawValue: components.dropLast().joined(separator: "-"))
            return (region, number)
        }
    }
}
