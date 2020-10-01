import Foundation
@testable import TencentCloudAPICore
import XCTest

class TencentCloudAPITests: XCTestCase {
    static let endpoint: TencentCloud.Endpoint = {
        let endpoint = TencentCloud.Endpoint(of: "cvm")
        precondition(endpoint != nil, "Please make sure a valid credential is passed through environment variables.")
        return endpoint!
    }()

    func testExample() throws {
        struct DescribeZones: TencentCloudAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = DescribeZonesResponse

            static var endpoint: TencentCloud.Endpoint { TencentCloudAPITests.endpoint }
            static let version = "2017-03-12"
        }

        let semaphore = DispatchSemaphore(value: 0)
        try DescribeZones.invoke(with: .init(), region: .ap_beijing) { response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            if let response = response {
                XCTAssertTrue(response.zones.count > 0)
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }

    func testErrorExample() throws {
        struct DescribeZones: TencentCloudAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = DescribeZonesResponse

            static var endpoint: TencentCloud.Endpoint { TencentCloudAPITests.endpoint }
            static let version = "2017-03-12"
        }

        let semaphore = DispatchSemaphore(value: 0)
        try DescribeZones.invoke(with: .init()) { response, error in
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

    func testMismatchedResponse() throws {
        struct DescribeZones: TencentCloudAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = FalseResponse

            static var endpoint: TencentCloud.Endpoint { TencentCloudAPITests.endpoint }
            static let version = "2017-03-12"
        }

        let semaphore = DispatchSemaphore(value: 0)
        try DescribeZones.invoke(with: .init(), region: .ap_beijing) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)

            let decodingError = error as? DecodingError
            XCTAssertNotNil(decodingError)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }

    func testCustomName() throws {
        struct MyAPI: TencentCloudAPI {
            typealias RequestPayload = DescribeZonesRequest
            typealias Response = DescribeZonesResponse

            static var endpoint: TencentCloud.Endpoint { TencentCloudAPITests.endpoint }
            static let action = "DescribeZones"
            static let version = "2017-03-12"
        }

        let semaphore = DispatchSemaphore(value: 0)
        try MyAPI.invoke(with: .init(), region: .ap_beijing) { response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            if let response = response {
                XCTAssertTrue(response.zones.count > 0)
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
