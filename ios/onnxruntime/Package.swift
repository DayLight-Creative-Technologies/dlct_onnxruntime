// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// DLCT fork: the iOS build of this FFI plugin under Swift Package Manager. It links the same ONNX Runtime
// binary the CocoaPods build links (ios/onnxruntime.podspec -> onnxruntime-objc 1.15.1 -> onnxruntime-c
// 1.15.1): Microsoft publishes no Swift package for ONNX Runtime, so the binary target is the onnxruntime-c
// 1.15.1 pod's own archive, by URL and checksum. Changing the version is a change to the C API the Dart
// bindings call (lib/src/bindings/), never a drop-in.

import PackageDescription

let package = Package(
    name: "onnxruntime",
    platforms: [
        // Flutter's iOS floor; the ONNX Runtime 1.15.1 binary's own minimum is 11.0.
        .iOS("13.0")
    ],
    products: [
        .library(name: "onnxruntime", targets: ["onnxruntime_ffi"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "onnxruntime_ffi",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                "onnxruntime"
            ]
        ),
        // onnxruntime-c 1.15.1 (https://github.com/CocoaPods/Specs, Specs/c/1/3/onnxruntime-c/1.15.1): a static
        // onnxruntime.framework for iOS device (arm64) and Simulator (arm64, x86_64).
        .binaryTarget(
            name: "onnxruntime",
            url: "https://onnxruntimepackages.z14.web.core.windows.net/pod-archive-onnxruntime-c-1.15.1.zip",
            checksum: "f3c88ff2a8a49101efb65f6c578dc8fa99ca6e5298ed876e42b9f171a6d99724"
        )
    ]
)
