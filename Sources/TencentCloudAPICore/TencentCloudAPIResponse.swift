@_exported import struct Foundation.UUID

public protocol TencentCloudAPIResponse: Decodable {
    var requestId: UUID { get }
}
