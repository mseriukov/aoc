// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let dayName = "Day3"
let package = Package(
    name: dayName,
    products: [
        .library(
            name: dayName,
            targets: [dayName])
    ],
    dependencies: [
        .package(path: "../AOCCommon")
    ],
    targets: [
        .target(
            name: dayName,
            dependencies: [
                .product(name: "AOCCommon", package: "AOCCommon")
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
