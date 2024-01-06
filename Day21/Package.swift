// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let dayName = "Day21"
let package = Package(
    name: dayName,
    products: [
        .library(
            name: dayName,
            targets: [dayName])
    ],
    dependencies: [
        .package(path: "../AOCCommon"),
        .package(url: "https://github.com/apple/swift-collections.git", branch: "release/1.1") 
    ],
    targets: [
        .target(
            name: dayName,
            dependencies: [
                .product(name: "AOCCommon", package: "AOCCommon"),
                .product(name: "Collections", package: "swift-collections")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: dayName + "Tests",
            dependencies: [
                .byNameItem(name: dayName, condition: nil)
            ]
        )
    ]
)
