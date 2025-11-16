// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AR6DoF-VR-SPM",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .executable(name: "AR6DoFApp", targets: ["AR6DoFApp"])
    ],
    targets: [
        .executableTarget(
            name: "AR6DoFApp",
            dependencies: [],
            path: "Sources/AR6DoFApp"
        )
    ]
)
