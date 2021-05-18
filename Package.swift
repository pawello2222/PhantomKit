// swift-tools-version:5.3

import PackageDescription

// MARK: - Dependencies

let depencencies: [Package.Dependency] = [
    .package(url: "https://github.com/duemunk/Async", .upToNextMajor(from: "2.1.0")),
    .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.0.0")),
    .package(name: "Xcore", url: "https://github.com/pawello2222/xcore.git", .upToNextMajor(from: "1.0.0")),
]

// MARK: - Targets

let targets: [Target] = [
    .target(name: "PhantomKit", dependencies: ["Async", "Xcore"], path: "Sources"),
    .testTarget(name: "PhantomKitTests", dependencies: ["PhantomKit", "Nimble"], path: "Tests"),
]

// MARK: - Package

let package = Package(
    name: "PhantomKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "PhantomKit", targets: ["PhantomKit"]),
    ],
    dependencies: depencencies,
    targets: targets,
    swiftLanguageVersions: [.v5]
)
