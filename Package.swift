// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CommonUtils",
  platforms: [.iOS(.v15), .macOS(.v12)],
  products: [
    .library(name: "CommonUtils", targets: ["CommonUtils"]),
    .library(name: "CommonUIUtils", targets: ["CommonUIUtils"])
  ],
  targets: [
    .target(name: "CommonUtils"),
    .target(name: "CommonUIUtils")
  ],
  swiftLanguageVersions: [.v5]
)
