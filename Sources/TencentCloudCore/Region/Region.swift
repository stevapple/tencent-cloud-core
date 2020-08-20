// List all available regions using tccli:
//   $ tccli cvm DescribeRegions

/// A `struct` representing a Tencent Cloud region.
extension TencentCloud {
    public struct Region: Equatable, Hashable {
        internal let area: Area
        internal let name: String
        internal let type: Type

        internal enum Area: String {
            // Asian Pacific (main)
            case ap
            // Europe
            case eu
            // North America
            case na
        }

        internal enum `Type`: String {
            case regular = ""
            case financial = "fsi"
            case open
        }

        internal static func parse(rawValue: String) -> (Area, String, Type)? {
            var components = rawValue.split(separator: "-")
            if components.count == 2 {
                components.append("")
            }
            guard components.count == 3,
                let area = Area(rawValue: .init(components[0])),
                String(components[1]).count > 1,
                let type = Type(rawValue: .init(components[2]))
            else {
                return nil
            }
            return (area, String(components[1]), type)
        }
    }
}
