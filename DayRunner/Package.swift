// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DayRunner",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "../AOCCommon"),
        .package(path: "../Day17")
    ],
    targets: [
        .executableTarget(
            name: "DayRunner",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "AOCCommon", package: "AOCCommon"),
                "Day17"
            ],
            path: "Sources"
        )
    ]

)
