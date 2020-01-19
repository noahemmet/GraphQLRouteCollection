// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaporGraphQL",
    products: [
        .library(
            name: "VaporGraphQL",
            targets: ["VaporGraphQL"]),
        .library(
            name: "StarWars",
            targets: ["StarWars"]),
        .executable(
            name: "Example",
            targets: ["Example"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "3.3.0")),
        // Forked from https://github.com/GraphQLSwift/GraphQL
      .package(url: "https://github.com/alexsteinerde/GraphQL.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "VaporGraphQL",
            dependencies: ["Vapor", "GraphQL"]),
        .target(
            name: "StarWars",
            dependencies: ["Vapor", "GraphQL"]),
        .target(
            name: "Example",
            dependencies: ["VaporGraphQL", "StarWars", "Vapor", "GraphQL"]),
        .testTarget(
            name: "VaporGraphQLTests",
            dependencies: ["VaporGraphQL", "StarWars"]),
    ]
)
