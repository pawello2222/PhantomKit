// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "PhantomKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "PhantomKit",
            targets: ["PhantomKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pawello2222/Appliable", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "PhantomKit",
            dependencies: ["Appliable"]
        ),
        .testTarget(
            name: "PhantomKitTests",
            dependencies: ["PhantomKit"]
        ),
    ]
)
