// swift-tools-version: 5.5
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
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.6.0"),
    ],
    targets: [
        .target(
            name: "RxUtility",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
            ]
        ),
        .testTarget(
            name: "RxUtilityTests",
            dependencies: ["RxUtility"]),
    ]
)
