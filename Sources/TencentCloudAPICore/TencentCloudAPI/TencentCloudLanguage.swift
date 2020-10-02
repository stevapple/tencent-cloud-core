extension TencentCloud {
    public struct Language: RawRepresentable {
        public typealias RawValue = String

        public let rawValue: String

        public init?(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var `default`: Self?
    }
}

extension TencentCloud.Language {
    public static var zh_CN: Self { Self(rawValue: "zh-CN")! }
    public static var en_US: Self { Self(rawValue: "en-US")! }
}
