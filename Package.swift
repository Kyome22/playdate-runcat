// swift-tools-version: 6.2

import PackageDescription

let xcode = (Context.environment["XPC_SERVICE_NAME"]?.count ?? 0) > 2

let package = Package(
    name: "RunCat",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "RunCat",
            type: xcode ? nil : .dynamic,
            targets: ["RunCat"]
        ),
    ],
    dependencies: [
        .package(path: "../PlaydateKit"),
    ],
    targets: [
        .target(
            name: "RunCat",
            dependencies: [.product(name: "PlaydateKit", package: "PlaydateKit")],
            exclude: ["Resources"],
            swiftSettings: [
                .enableExperimentalFeature("Embedded"),
                .unsafeFlags([
                    "-whole-module-optimization",
                    "-Xfrontend", "-disable-objc-interop",
                    "-Xfrontend", "-disable-stack-protector",
                    "-Xfrontend", "-function-sections",
                    "-Xfrontend", "-gline-tables-only",
                    "-Xcc", "-DTARGET_EXTENSION",
                ]),
            ],
        )
    ]
)
