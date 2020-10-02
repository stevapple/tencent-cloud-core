import Foundation
import TencentCloudAPI
import XCTest

class WrapperTests: XCTestCase {
    func testIdentityNumber() throws {
        struct Wrapped: Decodable {
            @IdentityNumber var id: UInt
        }

        let json = #"{"id":"10001"}"# .data(using: .utf8)!
        let unmatchedJson = #"{"id":"-10001"}"# .data(using: .utf8)!

        var decoded: Wrapped?
        XCTAssertNoThrow(decoded = try JSONDecoder().decode(Wrapped.self, from: json))
        XCTAssertEqual(decoded?.id, 10001)

        XCTAssertThrowsError(_ = try JSONDecoder().decode(Wrapped.self, from: unmatchedJson)) {
            guard let _ = $0 as? DecodingError else {
                XCTFail("Expected to throw a DecodingError.dataCorruptedError")
                return
            }
        }
    }

    func testAvailability() throws {
        struct Wrapped: Decodable {
            @Availability var state: Bool
        }

        let json = #"{"state":"UNAVAILABLE"}"# .data(using: .utf8)!
        let unmatchedJson = #"{"state":false}"# .data(using: .utf8)!

        var decoded: Wrapped?
        XCTAssertNoThrow(decoded = try JSONDecoder().decode(Wrapped.self, from: json))
        XCTAssertEqual(decoded?.state, false)

        XCTAssertThrowsError(_ = try JSONDecoder().decode(Wrapped.self, from: unmatchedJson)) {
            guard let _ = $0 as? DecodingError else {
                XCTFail("Expected to throw a DecodingError.dataCorruptedError")
                return
            }
        }
    }
}
