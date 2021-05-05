// swift-tools-version:5.3

import PackageDescription

// MARK: - Dependencies

extension Package.Dependency {
    static let xcore = Package.Dependency.package(
        name: "Xcore",
        url: "https://github.com/pawello2222/xcore.git",
        .branch("phantomKit")
    )

    static let swiftGen = Package.Dependency.package(
        url: "https://github.com/SwiftGen/SwiftGen.git",
        .upToNextMajor(from: "6.0.0")
    )
}

// MARK: - Targets

extension Target {
    static let main = Target.target(
        name: "PhantomKit",
        dependencies: ["Xcore"],
        path: "Sources"
    )

    static let test = Target.testTarget(
        name: "PhantomKitTests",
        dependencies: ["PhantomKit"],
        path: "Tests"
    )
}

// MARK: - Package

let package = Package(
    name: "PhantomKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "PhantomKit", targets: ["PhantomKit"]),
    ],
    dependencies: [.xcore, .swiftGen],
    targets: [.main, .test],
    swiftLanguageVersions: [.v5]
)
