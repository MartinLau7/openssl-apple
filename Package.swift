// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "openssl-apple",
	platforms: [
		.macOS("11")
	],
	products: [
		// Products define the executables and libraries a package produces, and make them visible to other packages.
		.executable(
			name: "openssl",
			targets: [
				"openssl-apple"
			]
		),
	],
    dependencies: [
        .package(url: "https://github.com/yury/FMake", from : "0.0.18")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "openssl-apple",
            dependencies: ["FMake"]),
    ]
)
