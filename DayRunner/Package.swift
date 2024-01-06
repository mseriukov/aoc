// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DayRunner",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "../AOCCommon"),
        .package(path: "../Day1"),
        .package(path: "../Day2"),
        .package(path: "../Day3"),
        .package(path: "../Day4"),
        .package(path: "../Day5"),
        .package(path: "../Day6"),
        .package(path: "../Day7"),
        .package(path: "../Day8"),
        .package(path: "../Day9"),
        .package(path: "../Day10"),
        .package(path: "../Day11"),
        .package(path: "../Day12"),
        .package(path: "../Day13"),
        .package(path: "../Day14"),
        .package(path: "../Day15"),
        .package(path: "../Day16"),
        .package(path: "../Day17"),
        .package(path: "../Day18"),
        .package(path: "../Day19"),
        .package(path: "../Day20"),
        .package(path: "../Day21"),
        .package(path: "../Day22"),
        .package(path: "../Day23"),
        .package(path: "../Day24"),
        .package(path: "../Day25"),
    ],
    targets: [
        .executableTarget(
            name: "DayRunner",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "AOCCommon", package: "AOCCommon"),
                "Day1",
                "Day2",
                "Day3",
                "Day4",
                "Day5",
                "Day6",
                "Day7",
                "Day8",
                "Day9",
                "Day10",
                "Day11",
                "Day12",
                "Day13",
                "Day14",
                "Day15",
                "Day16",
                "Day17",
                "Day18",
                "Day19",
                "Day20",
                "Day21",
                "Day22",
                "Day23",
                "Day24",
                "Day25",
            ],
            path: "Sources"
        )
    ]

)
