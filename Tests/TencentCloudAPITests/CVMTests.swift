import Foundation
@testable import TencentCloudAPI
import XCTest

class CVMTests: XCTestCase {
    func testDescribeZones() throws {
        let semaphore = DispatchSemaphore(value: 0)
        TencentCloud.CVM.DescribeZones.invoke(with: .init(), region: .ap_beijing) { response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            if let response = response {
                XCTAssertTrue(response.zones.count > 0)
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }

    func testDescribeZonesFsi() throws {
        let semaphore = DispatchSemaphore(value: 0)
        TencentCloud.CVM(region: .ap_shenzhen_fsi).DescribeZones.invoke(
            with: .init(),
            region: .ap_shenzhen_fsi
        ) { response, error in
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
