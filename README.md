# tencent-cloud-core

![CI](https://img.shields.io/github/workflow/status/stevapple/tencent-cloud-core/CI?label=CI&logo=github)
![SwiftPM](https://img.shields.io/github/v/release/stevapple/tencent-cloud-core?include_prereleases&label=SPM&color=orange&logo=swift)
![License](https://img.shields.io/github/license/stevapple/tencent-cloud-core)

This is a package for quickly adding Tencent Cloud support for Swift projects.

You can add it as a package dependency in `Package.swift` with:

```swift
.package(url: "https://github.com/stevapple/tencent-cloud-core", from: "0.2.0"),
```

Or, if you want to try out the latest features, with:

```swift
.package(url: "https://github.com/stevapple/tencent-cloud-core", from: "0.3.0-alpha"),
```

## `TencentCloudCore`

This module holds core structs and enumerations for Tencent Cloud, including:

- `TencentCloud.Region`: Tencent Cloud service region
- `TencentCloud.Zone`: Tencent Cloud service zone
- `TencentCloud.Credential`: Tencent Cloud API credential

You can add it as a target dependency in `Package.swift` with:

```swift
.product(name: "TencentCloudCore", package: "tencent-cloud-core"),
```

## `TencentCloudAPICore`

This module provides a simple model to define and invoke a Tencent Cloud API.

You can add it as a target dependency in `Package.swift` with:

```swift
.product(name: "TencentCloudAPICore", package: "tencent-cloud-core"),
```

This is available in `v0.1.0` with the name `TencentCloudAPI`.

For usage instruction, see [How to build a Tencent Cloud API with Swift](docs/build-api.md) (base on `v0.2.0`).

## `TencentCloudAPI`

This module provides a simple model to define and invoke a Tencent Cloud API.

You can add it as a target dependency in `Package.swift` with:

```swift
.product(name: "TencentCloudAPI", package: "tencent-cloud-core"),
```

This is available from `v0.3.0`.
