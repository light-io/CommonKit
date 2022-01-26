// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CommonKit",
  platforms: [.iOS(.v15), .macOS(.v12)],
  products: [
    .library(name: "CommonUtils", targets: ["CommonUtils"]),
    .library(name: "CommonUIUtils", targets: ["CommonUIUtils"]),
    .library(name: "RenderingKit", targets: ["RenderingKit"])
  ],
  targets: [
    .target(name: "CommonUtils"),
    .target(name: "CommonUIUtils"),
    .target(name: "RenderingKit", dependencies: ["CommonUtils"])
  ],
  swiftLanguageVersions: [.v5]
)
