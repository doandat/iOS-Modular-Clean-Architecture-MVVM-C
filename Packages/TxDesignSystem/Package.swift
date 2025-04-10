// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TxDesignSystem",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TxDesignSystem",
            targets: ["TxDesignSystem"]),
        .library(
            name: "TxFont",
            targets: ["TxFont"]),
        .library(
            name: "TxTheme",
            targets: ["TxTheme"]),
        .library(
            name: "TxUIComponent",
            targets: ["TxUIComponent"])
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins.git", exact: "0.57.1"),
        .package(path: "../TxLogger")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TxDesignSystem"
        ),
        .target(
            name: "TxFont",
            dependencies: [
                "TxDesignSystem"
            ],
            resources: [.process("Resources")]
        ),
        .target(
            name: "TxTheme",
            dependencies: [
                "TxDesignSystem"
            ],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        .target(
            name: "TxUIComponent",
            dependencies: [
                "TxDesignSystem",
                "TxTheme",
                "TxFont",
                "TxLogger"
            ],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]
        ),
        
        .testTarget(
            name: "TxDesignSystemTests",
            dependencies: ["TxDesignSystem", "TxTheme", "TxUIComponent"]
        ),
    ]
)
