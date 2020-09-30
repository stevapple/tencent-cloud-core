#if canImport(FoundationNetworking)
import class FoundationNetworking.URLSession
import class FoundationNetworking.URLSessionConfiguration
#else
import class Foundation.URLSession
import class Foundation.URLSessionConfiguration
#endif

extension TencentCloud {
    internal static let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15

        configuration.httpCookieAcceptPolicy = .never
        configuration.httpShouldSetCookies = false

        return URLSession(configuration: configuration)
    }()
}
