extension TencentCloud.Region: RawRepresentable, CustomStringConvertible {
    public typealias RawValue = String

    public init?(rawValue: String) {
        guard let (area, name, type) = Self.parse(rawValue: rawValue),
            !name.contains(where: { !$0.isLowercase })
        else {
            return nil
        }
        self.init(area: area, name: name, type: type)
    }

    public var rawValue: String {
        switch type {
        case .regular:
            return "\(area.rawValue)-\(name)"
        default:
            return "\(area.rawValue)-\(name)-\(type.rawValue)"
        }
    }

    public var description: String {
        self.rawValue
    }
}
