// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DolphinHTTP",
    products: [
        .library(
            name: "DolphinHTTP",
            targets: ["DolphinHTTP"]),
    ],
    dependencies: [
    
    ],
    targets: [
        .target(
            name: "DolphinHTTP",
            dependencies: []),
        .testTarget(
            name: "DolphinHTTPTests",
            dependencies: ["DolphinHTTP"]),
    ]
)
