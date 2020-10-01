import class Foundation.JSONDecoder
import class Foundation.JSONEncoder

extension TencentCloud {
    internal static let jsonEncoder = JSONEncoder()
    internal static let jsonDecoder = JSONDecoder()
}
