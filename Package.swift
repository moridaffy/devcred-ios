// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DevCred",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "DevCred",
      targets: ["DevCred"]
    ),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/onevcat/Kingfisher", from: "7.8.1")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "DevCred",
      dependencies: ["Kingfisher"],
      path: "Sources/devcred-ios",
      resources: [
        .process("Images/icon_link_behance.png"),
        .process("Images/icon_link_dribbble.png"),
        .process("Images/icon_link_facebook.png"),
        .process("Images/icon_link_github.png"),
        .process("Images/icon_link_instagram.png"),
        .process("Images/icon_link_linkedin.png"),
        .process("Images/icon_link_telegram.png"),
        .process("Images/icon_link_twitter.png"),
        .process("Images/icon_link_vk.png"),
        .process("Images/icon_link_web.png"),
        .process("Images/icon_link_youtube.png")
      ]
    ),
    .testTarget(
      name: "devcredTests",
      dependencies: ["DevCred"],
      path: "Tests/devcred-iosTests"
    ),
  ]
)
