// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-sequence-cardinal",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Sequence Cardinal",
            targets: ["Sequence Cardinal"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-sequence.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-sequence-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-iterator.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Sequence Cardinal",
            dependencies: [
                .product(name: "Sequence", package: "swift-sequence"),
                .product(name: "Sequence Property", package: "swift-sequence-property"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Iterator", package: "swift-iterator"),
            ]
        ),
        .testTarget(
            name: "Sequence Cardinal Tests",
            dependencies: [
                "Sequence Cardinal",
                .product(name: "Sequence", package: "swift-sequence"),
                .product(name: "Sequence Property", package: "swift-sequence-property"),
                .product(name: "Iterator", package: "swift-iterator"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = [
        .enableExperimentalFeature("BuiltinModule")
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
