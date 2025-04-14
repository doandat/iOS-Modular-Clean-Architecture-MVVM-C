// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TxNetworking",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TxNetworkModels",
            targets: ["TxNetworkModels"]
        ),
        .library(
            name: "TxApiClient",
            targets: ["TxApiClient"]
        ),
        .library(
            name: "TxGithubUserManagerInterface",
            targets: ["TxGithubUserManagerInterface"]
        ),
        .library(
            name: "TxGithubUserManagerService",
            targets: ["TxGithubUserManagerService"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", exact: "15.0.3"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.2"),
        .package(path: "../TxLogger"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TxNetworkModels",
            dependencies: [
                "TxLogger"
            ]
        ),
        .target(
            name: "TxApiClient",
            dependencies: [
                "TxLogger",
                "TxNetworkModels",
                .product(name: "Moya", package: "Moya")
            ]
        ),
        .target(
            name: "TxMoyaExt",
            dependencies: [
                "TxNetworkModels",
                "TxLogger",
                "SwiftyJSON",
                .product(name: "Moya", package: "Moya")
            ]
        ),
        .target(
            name: "TxGithubUserManagerInterface",
            dependencies: [
                "TxLogger",
                "TxNetworkModels"
            ]
        ),
        .target(
            name: "TxGithubUserManagerService",
            dependencies: [
                "TxGithubUserManagerInterface",
                "SwiftyJSON",
                "TxMoyaExt",
                .product(name: "Moya", package: "Moya")
            ]
        ),
        .testTarget(
            name: "TxNetworkingTests",
            dependencies: ["TxGithubUserManagerService"]
        ),
    ]
)
