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
