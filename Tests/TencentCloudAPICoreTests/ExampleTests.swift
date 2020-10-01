import Foundation
@testable import TencentCloudAPICore
import XCTest

class TencentCloudAPICoreTests: XCTestCase {
    static let endpoint = TencentCloud.Endpoint(of: "cvm")

    func testExample() {
        struct DescribeZones: TencentCloudRegionalAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = DescribeZonesResponse

            let endpoint: TencentCloud.Endpoint
            static let version = "2017-03-12"
        }
        let api = DescribeZones(endpoint: Self.endpoint)

        let semaphore = DispatchSemaphore(value: 0)
        api.invoke(with: .init(), region: .ap_beijing) { response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            if let response = response {
                XCTAssertTrue(response.zones.count > 0)
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }

    func testErrorExample() {
        struct DescribeZones: TencentCloudGlobalAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = DescribeZonesResponse

            let endpoint: TencentCloud.Endpoint
            static let version = "2017-03-12"
        }
        let api = DescribeZones(endpoint: Self.endpoint)

        let semaphore = DispatchSemaphore(value: 0)
        api.invoke(with: .init()) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)

            let apiError = error as? TencentCloud.APIError
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, "MissingParameter")
            XCTAssertEqual(apiError?.message, "The request is missing a required parameter `Region`.")
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }

    func testMismatchedResponse() {
        struct DescribeZones: TencentCloudRegionalAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = FalseResponse

            let endpoint: TencentCloud.Endpoint
            static let version = "2017-03-12"
        }
        let api = DescribeZones(endpoint: Self.endpoint)

        let semaphore = DispatchSemaphore(value: 0)
        api.invoke(with: .init(), region: .ap_beijing) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)

            let decodingError = error as? DecodingError
            XCTAssertNotNil(decodingError)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }

    func testCustomName() {
        struct MyAPI: TencentCloudRegionalAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = DescribeZonesResponse

            let endpoint: TencentCloud.Endpoint
            static let action = "DescribeZones"
            static let version = "2017-03-12"
        }
        let api = MyAPI(endpoint: Self.endpoint)

        let semaphore = DispatchSemaphore(value: 0)
        api.invoke(with: .init(), region: .ap_beijing) { response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            if let response = response {
                XCTAssertTrue(response.zones.count > 0)
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }

    func testChineseLanguage() {
        struct DescribeZones: TencentCloudRegionalAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = DescribeZonesResponse

            let endpoint: TencentCloud.Endpoint
            static let version = "2017-03-12"
        }
        let api = DescribeZones(endpoint: Self.endpoint)

        let semaphore = DispatchSemaphore(value: 0)
        api.invoke(with: .init(), region: .ap_beijing, language: .zh_CN) { response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            if let response = response {
                XCTAssertTrue(response.zones.count > 0)
                XCTAssertTrue(response.zones.map { $0.name }.contains("北京一区"))
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
