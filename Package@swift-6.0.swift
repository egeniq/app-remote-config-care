// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "care",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .executable(
            name: "care",
            targets: ["care"]
        )
    ],
    dependencies: [
        // .package(name: "app-remote-config", path: "../app-remote-config"),
        .package(url: "https://github.com/egeniq/app-remote-config", from: "0.6.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6")
    ],
    targets: [
        .executableTarget(
            name: "care",
            dependencies: [
                .product(name: "AppRemoteConfig", package: "app-remote-config"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Yams", package: "Yams")
            ]),
    ]
)
