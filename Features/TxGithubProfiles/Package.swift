// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TxGithubProfiles",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TxGithubProfiles",
            targets: ["TxGithubProfiles"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins.git", exact: "0.57.1"),
        .package(url: "https://github.com/hmlongco/Resolver.git", exact: "1.5.1"),
        .package(path: "../../Packages/TxDesignSystem"),
        .package(path: "../../Packages/TxLogger"),
        .package(path: "../../Packages/TxFoundation"),
        .package(path: "../../Packages/TxDeeplink"),
        .package(path: "../../Packages/TxLocalization"),
        
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TxGithubProfiles",
            dependencies: [
                "Resolver",
                "TxLogger",
                "TxFoundation",
                "TxDeeplink",
                "TxLocalization",
                .product(name: "TxDesignSystem", package: "TxDesignSystem"),
                .product(name: "TxFont", package: "TxDesignSystem"),
                .product(name: "TxTheme", package: "TxDesignSystem"),
                .product(name: "TxUIComponent", package: "TxDesignSystem")
            ],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        .testTarget(
            name: "TxGithubProfilesTests",
            dependencies: ["TxGithubProfiles"]
        ),
    ]
)
