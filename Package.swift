// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PromptManager",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "PromptManager",
            targets: ["PromptManager"]),
    ],
    targets: [
        .target(
            name: "PromptManager"),
        .testTarget(
            name: "PromptManagerTests",
            dependencies: ["PromptManager"]),
    ]
)
