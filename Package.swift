// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "PhantomKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "PhantomKit",
            targets: ["PhantomKit"]
        ),
    ],
    targets: [
        .target(
            name: "PhantomKit"
        ),
        .testTarget(
            name: "PhantomKitTests",
            dependencies: ["PhantomKit"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
