// swift-tools-version: 5.9.0
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
            dependencies: []),
        .testTarget(
            name: "plasmaTests",
            dependencies: [
                "plasma",
            ])
    ]
)
