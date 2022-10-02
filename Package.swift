// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "animate",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Animate",
            targets: ["Animate"]
        )
    ],
    targets: [
        .target(
            name: "Animate"
        )
    ]
)
