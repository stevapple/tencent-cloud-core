import Foundation
@testable import TencentCloudAPI
import XCTest

class TencentCloudAPITests: XCTestCase {
    func testExample() throws {
        let endpoint = TencentCloud.Endpoint(of: "cvm")
        XCTAssertNotNil(endpoint, "Please make sure a valid credential is passed through environment variables.")
        let describeZones = TencentCloud.API<Request, Response>(endpoint: endpoint!, action: "DescribeZones", version: "2017-03-12")

        let semaphore = DispatchSemaphore(value: 0)
        try describeZones.invoke(with: .init(), region: .ap_beijing) { response, error in
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
        let endpoint = TencentCloud.Endpoint(of: "cvm")
        XCTAssertNotNil(endpoint, "Please make sure a valid credential is passed through environment variables.")
        let describeZones = TencentCloud.API<Request, Response>(endpoint: endpoint!, action: "DescribeZones", version: "2017-03-12")

        let semaphore = DispatchSemaphore(value: 0)
        try describeZones.invoke(with: .init()) { response, error in
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
        struct ZoneResponse: TencentCloudAPIResponse {
            let state: String
            let id: UInt
            let zone: TencentCloud.Zone
            let name: String
            let requestId: UUID

            enum CodingKeys: String, CodingKey {
                case state = "ZoneState"
                case id = "ZoneId"
                case zone = "Zone"
                case name = "ZoneName"
                case requestId = "RequestId"
            }
        }
        let endpoint = TencentCloud.Endpoint(of: "cvm")
        XCTAssertNotNil(endpoint, "Please make sure a valid credential is passed through environment variables.")
        let describeZones = TencentCloud.API<Request, ZoneResponse>(endpoint: endpoint!, action: "DescribeZones", version: "2017-03-12")

        let semaphore = DispatchSemaphore(value: 0)
        try describeZones.invoke(with: .init(), region: .ap_beijing) { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)

            let decodingError = error as? DecodingError
            XCTAssertNotNil(decodingError)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
