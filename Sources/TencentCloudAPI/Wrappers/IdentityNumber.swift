@propertyWrapper
public struct IdentityNumber {
    public let wrappedValue: UInt

    public init(wrappedValue: UInt) {
        self.wrappedValue = wrappedValue
    }
}

extension IdentityNumber: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let id = try container.decode(String.self)
        if let id = UInt(id) {
            self.init(wrappedValue: id)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected \(container.codingPath.last?.stringValue ?? "Id") to be an unsigned integer, but `\(id)` does not forfill format")
        }
    }
}
