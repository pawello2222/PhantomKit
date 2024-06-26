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
            name: "PhantomKit",
            targets: ["PhantomKitAPI", "PhantomKitCore", "PhantomKitLog", "PhantomKitUI"]
        ),
        .library(
            name: "PhantomKitAPI",
            targets: ["PhantomKitAPI"]
        ),
        .library(
            name: "PhantomKitCore",
            targets: ["PhantomKitCore"]
        ),
        .library(
            name: "PhantomKitLog",
            targets: ["PhantomKitLog"]
        ),
        .library(
            name: "PhantomKitUI",
            targets: ["PhantomKitUI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pawello2222/Appliable", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "PhantomKitAPI",
            dependencies: ["PhantomKitCore", "PhantomKitLog"]
        ),
        .target(
            name: "PhantomKitCore",
            dependencies: ["Appliable"]
        ),
        .target(
            name: "PhantomKitLog",
            dependencies: ["Appliable"]
        ),
        .target(
            name: "PhantomKitUI",
            dependencies: ["PhantomKitCore"]
        ),
        .testTarget(
            name: "PhantomKitAPITests",
            dependencies: ["PhantomKitAPI"]
        ),
        .testTarget(
            name: "PhantomKitCoreTests",
            dependencies: ["PhantomKitCore"]
        ),
        .testTarget(
            name: "PhantomKitLogTests",
            dependencies: ["PhantomKitCore", "PhantomKitLog"]
        ),
        .testTarget(
            name: "PhantomKitUITests",
            dependencies: ["PhantomKitUI"]
        )
    ]
)
