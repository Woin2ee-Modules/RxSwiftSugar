// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxUtility",
    products: [
        .library(
            name: "RxUtility",
            targets: ["RxUtility"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RxUtility",
            dependencies: []),
        .testTarget(
            name: "RxUtilityTests",
            dependencies: ["RxUtility"]),
    ]
)
