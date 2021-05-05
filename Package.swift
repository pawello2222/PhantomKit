// swift-tools-version:5.3

import PackageDescription

// MARK: - Dependencies

let depencencies: [Package.Dependency] = [
    .package(name: "Xcore", url: "https://github.com/pawello2222/xcore.git", .branch("phantomKit")),
]

// MARK: - Targets

let targets: [Target] = [
    .target(name: "PhantomKit", dependencies: ["Xcore"], path: "Sources"),
    .testTarget(name: "PhantomKitTests", dependencies: ["PhantomKit"], path: "Tests"),
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
