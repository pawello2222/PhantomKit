// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "PhantomKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "PhantomKit", targets: ["PhantomKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "10.0.0"))
    ],
    targets: [
        .target(
            name: "PhantomKit",
            dependencies: ["Xcore"]
        ),
        .testTarget(
            name: "PhantomKitTests",
            dependencies: ["PhantomKit", "Nimble"],
            exclude: ["Resources/Info.plist"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
