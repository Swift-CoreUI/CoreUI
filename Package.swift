// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUI",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "CoreUI", targets: ["CoreUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CoreUI",
            dependencies: []),
        .testTarget(
            name: "CoreUITests",
            dependencies: ["CoreUI"]),
    ]
)
