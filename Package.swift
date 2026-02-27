// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PostBuildAnalyzer",
    platforms: [
        .macOS(.v15)
    ],
    targets: [
        .executableTarget(
            name: "PostBuildAnalyzer",
            path: "PostBuildAnalyzer/PostBuildAnalyzer"
        )
    ]
)
