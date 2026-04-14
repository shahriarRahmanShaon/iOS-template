// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TemplateDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "TemplateDomain", targets: ["TemplateDomain"]),
    ],
    targets: [
        .target(name: "TemplateDomain"),
    ]
)
