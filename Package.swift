// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "care",
    defaultLocalization: "en",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8), .macCatalyst(.v15)],
    products: [
        .executable(
            name: "care",
            targets: ["care"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/egeniq/app-remote-config", from: "0.0.2"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6")
    ],
    targets: [
        .executableTarget(
            name: "care",
            dependencies: [
                .product(name: "AppRemoteConfig", package: "app-remote-config"),
                .product(name: "Yams", package: "Yams"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
    ]
)
