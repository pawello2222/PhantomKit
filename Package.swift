// swift-tools-version:5.3

import PackageDescription

// MARK: - Dependencies

let depencencies: [Package.Dependency] = [
    .package(name: "Xcore", url: "https://github.com/pawello2222/xcore.git", .branch("phantomKit")),
    .package(url: "https://github.com/sindresorhus/Defaults", .upToNextMajor("4.2.2")),
]

// MARK: - Targets

let targets: [Target] = [
    .target(name: "PhantomKit", dependencies: ["Xcore", "Defaults"], path: "Sources"),
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
