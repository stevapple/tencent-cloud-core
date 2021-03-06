# How to build a Tencent Cloud API with Swift

This guide will instruct you to build and invoke a Tencent Cloud API in pure and pretty Swift code. It's never been easier to invoke Tencent Cloud APIs with Swift!

Let's take the [DescribeZones](https://intl.cloud.tencent.com/document/product/213/35071) API from [CVM](https://intl.cloud.tencent.com/product/cvm) service for example.

## Build the endpoint

First, import and build the endpoint with its host name or service info:

```swift
import TencentCloudAPICore

let endpoint = TencentCloud.Endpoint(of: "cvm")
// With region
let beijingEndpoint = TencentCloud.Endpoint(of: "cvm", region: .ap_beijing)
// With host name
let shenzhenFsiEndpoint = TencentCloud.Endpoint("cvm.ap-shenzhen-fsi.tencentcloudapi.com")
```

You can easily access all known regions provided by `TencentCloudCore`.

The API credential will be automatically inferred during invocation from the environment using the following keys: `TENCENT_SECRET_ID`, `TENCENT_SECRET_KEY`, `TENCENT_SESSION_TOKEN`. In SCF environment, it can also be inferred from the runtime. If there's no credential in the environment, you may need to provide one when creating the endpoint, or the invocations will fail:

```swift
let customEndpoint = TencentCloud.Endpoint(
    of: "cvm",
    credential: .init(secretId: "AKIDz8krbsJ5yKBZQpn74WFkmLPx3*******",
                      secretKey: "Gu5t9xGARNpq86cd98joQYCN3*******")
)
```

## Build the request and response

Then, build the request payload and response body for a specific API.

The request payload should conform to `Codable`. In this case the request has a void payload.

```swift
struct DescribeZonesRequest: Codable {}
```

The response body should conform to `TencentCloudAPIResponse`, which requires a `requestId` property in addtion to `Decodable`.

You may want to cast the type of the response to make it more Swifty. Go ahead with a custom `init(from decoder: Decoder) throws` initializer!

```swift
import Foundation

struct DescribeZonesResponse: TencentCloudAPIResponse {
    let count: Int
    let zones: [ZoneInfo]
    let requestId: UUID

    enum CodingKeys: String, CodingKey {
        case count = "TotalCount"
        case zones = "ZoneSet"
        case requestId = "RequestId"
    }

    struct ZoneInfo: Decodable {
        let isAvailable: Bool
        let id: UInt
        let zone: TencentCloud.Zone
        let name: String

        enum CodingKeys: String, CodingKey {
            case state = "ZoneState"
            case id = "ZoneId"
            case zone = "Zone"
            case name = "ZoneName"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let state = try container.decode(String.self, forKey: .state)
            switch state {
            case "AVAILABLE": isAvailable = true
            case "UNAVAILABLE": isAvailable = false
            default:
                throw DecodingError.dataCorruptedError(forKey: .state, in: container, debugDescription: "Expected ZoneState to be AVAILABLE or UNAVAILABLE, but `\(state)` does not forfill format")
            }

            let idString = try container.decode(String.self, forKey: .id)
            guard let id = UInt(idString) else {
                throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "Expected ZoneId to be an integer, but `\(idString)` does not forfill format")
            }
            self.id = id

            zone = try container.decode(TencentCloud.Zone.self, forKey: .zone)
            name = try container.decode(String.self, forKey: .name)
        }
    }
}
```

To make the response structure clear, you're suggested to use nested types (or `typealias`) and not to change the data hierarchy. The `CodingKeys` raw values should directly correspond to JSON keys, and case names should match the property names, which are simpler and more expressive.

## Build the API

Then you can easily build the API with the pre-defined protocols.

`TencentCloudGlobalAPI` corresponds to APIs that don't need a `Region` input, and `TencentCloudRegionalAPI`s will always need one.

```swift
struct DescribeZones: TencentCloudRegionalAPI {
    typealias RequestPayload = DescribeZonesRequest
    typealias Response = DescribeZonesResponse

    let endpoint: TencentCloud.Endpoint
    static let version = "2017-03-12"
}

let describeZones = DescribeZones(endpoint: endpoint)
```

Note that the API `Action` will be inferred from its struct/class/enum name. If you want to use another name, you'll need to provide an `action` additionally:

```swift
struct MyAPI: TencentCloudRegionalAPI {
    typealias RequestPayload = DescribeZonesRequest
    typealias Response = DescribeZonesResponse

    let endpoint: TencentCloud.Endpoint
    static let version = "2017-03-12"
}
```

## Invoke the API

Finally, feel free to invoke the API:

```swift
describeZones.invoke(with: .init(), region: .ap_beijing) { (response, error) in
    if let error = error {
        print("Error: \(error)")
        return
    }
    response!.zones.forEach {
        print($0.name)
    }
}
```

The sample code above provides a simple template for error handling. The errors may come from networking, JSON decoding and Tencent Cloud platform.
