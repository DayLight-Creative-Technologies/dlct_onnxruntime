// The Dart bindings find the ONNX Runtime C API by name: lib/src/bindings/bindings.dart opens
// DynamicLibrary.process() on iOS and looks up OrtGetApiBase with dlsym. No native code in the app calls
// it, and ONNX Runtime arrives as a static framework, so without a reference the linker never loads the
// object that defines OrtGetApiBase and the lookup fails ("Failed to lookup symbol 'OrtGetApiBase'"):
// media moderation then cannot load its model and blocks every upload. This reference, marked used so
// dead-code stripping keeps it, links that object into the app. (The CocoaPods build gets the same effect
// from onnxruntime-objc's wrapper, which calls the C API.)

#include <onnxruntime/onnxruntime_c_api.h>

#include "onnxruntime_ffi.h"

// lib/src/ort_env.dart asks GetApi for OrtApiVersion.api14 by default; the linked runtime must serve it.
_Static_assert(ORT_API_VERSION >= 14, "the linked ONNX Runtime must serve the C API version the Dart bindings request");

__attribute__((used)) const OrtApiBase *(*const onnxruntime_ffi_ort_get_api_base)(void) = &OrtGetApiBase;
