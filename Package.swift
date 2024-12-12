// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "SwiftAlgorithms",
    products: [
        .library(
            name: "SwiftAlgorithms",
            targets: ["SwiftAlgorithms"]),
    ],
    targets: [
        .target(
            name: "SwiftAlgorithms",
            dependencies: []),
        .testTarget(
            name: "SwiftAlgorithmsTests",
            dependencies: ["SwiftAlgorithms"]),
    ]
)
