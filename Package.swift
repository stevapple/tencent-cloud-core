// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "tencent-cloud-core",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "TencentCloudCore", targets: ["TencentCloudCore"]),
        .library(name: "TencentCloudAPICore", targets: ["TencentCloudAPICore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "TencentCloudCore", dependencies: []),
        .testTarget(name: "TencentCloudCoreTests", dependencies: ["TencentCloudCore"]),
        .target(name: "TencentCloudAPICore", dependencies: ["TencentCloudCore", "Crypto"]),
        .testTarget(name: "TencentCloudAPICoreTests", dependencies: ["TencentCloudAPICore"]),
    ]
)
