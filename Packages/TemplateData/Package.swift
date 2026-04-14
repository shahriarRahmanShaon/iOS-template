// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TemplateData",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "TemplateData", targets: ["TemplateData"]),
    ],
    dependencies: [
        .package(path: "../TemplateDomain"),
    ],
    targets: [
        .target(
            name: "TemplateData",
            dependencies: [
                .product(name: "TemplateDomain", package: "TemplateDomain"),
            ]
        ),
    ]
)
