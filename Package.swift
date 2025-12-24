// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorMindboxSdk",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CapacitorMindboxSdk",
            targets: ["CapMindboxPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CapMindboxPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapMindboxPlugin"),
        .testTarget(
            name: "CapMindboxPluginTests",
            dependencies: ["CapMindboxPlugin"],
            path: "ios/Tests/CapMindboxPluginTests")
    ]
)