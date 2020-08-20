// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "tencent-cloud-core",
    products: [
        .library(name: "TencentCloudCore", targets: ["TencentCloudCore"]),
    ],
    targets: [
        .target(name: "TencentCloudCore", dependencies: []),
        .testTarget(name: "TencentCloudCoreTests", dependencies: ["TencentCloudCore"]),
    ]
)
