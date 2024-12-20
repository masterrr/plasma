// swift-tools-version: 5.9.0
import PackageDescription

let package = Package(
    name: "plasma",
    products: [
        .library(
            name: "plasma",
            targets: ["plasma"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-testing", branch: "main")
    ],
    targets: [
        .target(
            name: "plasma",
            dependencies: []),
        .testTarget(
            name: "plasmaTests",
            dependencies: [
                "plasma",
                .product(name: "Testing", package: "swift-testing"),
            ])
    ]
)
