// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "plasma",
    products: [
        .library(
            name: "plasma",
            targets: ["plasma"]),
    ],
    targets: [
        .target(
            name: "plasma",
            dependencies: []),  // Added explicit empty dependencies
        .testTarget(
            name: "plasmaTests",
            dependencies: ["plasma"])
    ]
)
