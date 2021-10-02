// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PhantomKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(name: "PhantomKit", targets: ["PhantomKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/duemunk/Async", .upToNextMajor(from: "2.1.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.0.0")),
        .package(name: "Xcore", url: "https://github.com/pawello2222/xcore.git", .branch("main")),
    ],
    targets: [
        .target(name: "PhantomKit", dependencies: ["Async", "Xcore"]),
        .testTarget(name: "PhantomKitTests", dependencies: ["PhantomKit", "Nimble"]),
    ],
    swiftLanguageVersions: [.v5]
)
