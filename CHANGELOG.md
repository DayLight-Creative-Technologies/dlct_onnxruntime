## 1.4.3

* iOS: Swift Package Manager support. `ios/onnxruntime/Package.swift` links the same ONNX Runtime the CocoaPods
  build links, 1.15.1: Microsoft publishes no Swift package for ONNX Runtime, so the binary target is the
  `onnxruntime-c` 1.15.1 pod's own archive by URL and checksum (static `onnxruntime.framework`, device arm64,
  Simulator arm64 + x86_64). The Dart bindings look up `OrtGetApiBase` with `dlsym`, and nothing in the app calls
  it, so the package's one C source keeps a `used` reference to it: without that, the linker never loads it from
  the static framework and moderation cannot create a session. The C source also asserts at compile time that
  the linked headers serve C API version 14, the version the bindings request.
* iOS: `ios/onnxruntime.podspec` is unchanged; the CocoaPods build still links `onnxruntime-objc` 1.15.1.
* Example: iOS deployment target 12.0 -> 13.0 (the package's platform, Flutter's iOS floor).
* CI: `.github/workflows/build.yml` builds the example for the iOS Simulator with Swift Package Manager (fails unless
  Flutter links onnxruntime through its Swift package and the app defines `OrtGetApiBase`) and with CocoaPods.

## 1.4.2

* Android: replace bundled `libonnxruntime.so` (arm64-v8a, armeabi-v7a) with
  16 KB-page-aligned builds extracted from the official ONNX Runtime 1.20.0
  Android AAR (`com.microsoft.onnxruntime:onnxruntime-android`, Maven Central).
  Upstream 1.4.1 shipped ORT 1.15.1 `.so`s aligned to 4 KB (`p_align=0x1000`),
  which Google Play rejects for apps targeting Android 15+: *"Library that does
  not support 16 KB: base/lib/arm64-v8a/libonnxruntime.so"*. The replacements
  are `p_align=0x4000` (verified via ELF program-header inspection).
* Dart FFI bindings are unchanged. They request ORT C-API v14; the ORT C API is
  append-only and backward-compatible, so a 1.20.0 runtime serves the v14
  request. Verified the swapped `.so` still exports `OrtGetApiBase`.
* iOS / macOS / Windows / Linux are untouched (the iOS/macOS `onnxruntime-objc`
  pod stays at 1.15.1). The 16 KB page-size requirement is 64-bit-Android-only.
* DLCT fork of gtbluesky/onnxruntime_flutter@1.4.1.

## 1.4.1

* Fixes a memory leak when creating tensor.

## 1.4.0

* Fixes a memory leak when creating tensor.

## 1.3.0

* Attempts to support macOS, Windows and Linux.

## 1.2.0

* Compatible with Gradle8.

## 1.1.0

* Exposes some methods of input and output name.
* Adds some documentation comments.

## 1.0.0

* Initial release.
