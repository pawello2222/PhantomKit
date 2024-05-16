// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "PhantomKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "PhantomKitCore",
            targets: ["PhantomKitCore"]
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
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pawello2222/Appliable", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "PhantomKitCore",
            dependencies: ["Appliable"]
        ),
        .target(
            name: "PhantomKitLogger",
            dependencies: ["Appliable"]
        ),
        .target(
            name: "PhantomKitNetworking",
            dependencies: ["PhantomKitCore", "PhantomKitLogger"]
        ),
        .target(
            name: "PhantomKitUI",
            dependencies: ["PhantomKitCore"]
        ),
        .testTarget(
            name: "PhantomKitCoreTests",
            dependencies: ["PhantomKitCore"]
        )
    ]
)
