// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxSwiftSugar",
    products: [
        .library(
            name: "RxSwiftSugar-Dynamic",
            type: .dynamic,
            targets: ["RxSwiftSugar"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.6.0")
    ],
    targets: [
        .target(
            name: "RxSwiftSugar",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
        .testTarget(
            name: "RxSwiftSugarTests",
            dependencies: [
                "RxSwiftSugar",
                .product(name: "RxTest", package: "RxSwift"),
                .product(name: "RxBlocking", package: "RxSwift")
            ]
        )
    ]
)
