@dynamicMemberLookup
protocol ExposingDefault {
    static var `default`: Self { get }
    static subscript<Property>(dynamicMember keyPath: KeyPath<Self, Property>) -> Property { get }
}

extension ExposingDefault {
    public static subscript<Property>(dynamicMember keyPath: KeyPath<Self, Property>) -> Property {
        `default`[keyPath: keyPath]
    }
}
