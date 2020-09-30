# tencent-cloud-core

This is a package for quickly adding Tencent Cloud support for Swift projects.

You can add it as a package dependency in `Package.swift` with:

```swift
.package(url: "https://github.com/stevapple/tencent-cloud-core", from: "0.1.0")
```

## `TencentCloudCore`

This module holds core structs and enumerations for Tencent Cloud, including:

- `TencentCloud.Region`: Tencent Cloud service region
- `TencentCloud.Zone`: Tencent Cloud service zone
- `TencentCloud.Credential`: Tencent Cloud API credential

You can add it as a target dependency in `Package.swift` with:

```swift
.product(name: "TencentCloudCore", package: "tencent-cloud-core")
```

## `TencentCloudAPI`

This module provides a simple model to define and invoke a Tencent Cloud API.

You can add it as a target dependency in `Package.swift` with:

```swift
.product(name: "TencentCloudCore", package: "tencent-cloud-core")
```

For usage instruction, see [API.md](API.md).
