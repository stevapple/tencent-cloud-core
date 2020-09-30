import class Foundation.JSONEncoder
import class Foundation.JSONDecoder

extension TencentCloud {
    internal static let jsonEncoder = JSONEncoder()
    internal static let jsonDecoder = JSONDecoder()
}