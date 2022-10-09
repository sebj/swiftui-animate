// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swiftui-animate",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
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
