// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

let package = Package(
    name: "MobioRichNotification",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "MobioRichNotification",
            targets: ["MobioRichNotification"]),
    ],
    targets: [
        .target(
            name: "MobioRichNotification",
            path: "Sources")
    ]
)
