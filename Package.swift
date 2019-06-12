// swift-tools-version:4.2
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
        .package(url: "https://github.com/GraphQLSwift/GraphQL.git", .branch("master")),
        .package(url: "https://github.com/noahemmet/Graphiti.git", .branch("0.9.0")), // note this is a branch
    ],
    targets: [
        .target(
            name: "VaporGraphQL",
            dependencies: ["Vapor", "GraphQL", "Graphiti"]),
        .target(
            name: "StarWars",
            dependencies: ["Vapor", "GraphQL", "Graphiti"]),
        .target(
            name: "Example",
            dependencies: ["VaporGraphQL", "StarWars", "Vapor", "GraphQL", "Graphiti"]),
        .testTarget(
            name: "VaporGraphQLTests",
            dependencies: ["VaporGraphQL", "StarWars"]),
    ]
)
