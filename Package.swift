// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CheckCoreData",
    products: [
        .executable(
            name: "checkcoredata", targets: ["CheckCoreData"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/phimage/MomXML" , .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON" , .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(
            name: "CheckCoreData",
            dependencies: ["SwiftyJSON", "MomXML"],
            path: "Sources"
        )
    ]
)
