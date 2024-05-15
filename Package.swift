// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PhantomKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        .library(
            name: "PhantomKit",
            targets: ["PhantomKit"]
        ),
        .library(
            name: "PhantomKitLogger",
            targets: ["PhantomKitLogger"]
        ),
        .library(
            name: "PhantomKitNetworking",
            targets: ["PhantomKitNetworking"]
        ),
        .library(
            name: "PhantomKitUI",
            targets: ["PhantomKitUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pawello2222/Appliable", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "PhantomKit",
            dependencies: ["Appliable"]
        ),
        .target(
            name: "PhantomKitLogger",
            dependencies: ["PhantomKit"]
        ),
        .target(
            name: "PhantomKitNetworking",
            dependencies: ["PhantomKit", "PhantomKitLogger"]
        ),
        .target(
            name: "PhantomKitUI",
            dependencies: ["PhantomKit"]
        ),
        .testTarget(
            name: "PhantomKitTests",
            dependencies: ["PhantomKit"]
        )
    ]
)
