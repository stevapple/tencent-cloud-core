@propertyWrapper
public struct Availability {
    public let wrappedValue: Bool

    public init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
}

extension Availability: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let state = try container.decode(String.self)
        switch state {
        case "AVAILABLE":
            self.init(wrappedValue: true)
        case "UNAVAILABLE":
            self.init(wrappedValue: false)
        default:
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected \(container.codingPath.last?.stringValue ?? "State") to be AVAILABLE or UNAVAILABLE, but `\(state)` does not forfill format")
        }
    }
}
