// The onnxruntime_ffi target has no API of its own: the Dart bindings call ONNX Runtime's C API directly
// (lib/src/bindings/). Its one source keeps OrtGetApiBase linked; see ort_api_base_anchor.c.
#ifndef ONNXRUNTIME_FFI_H
#define ONNXRUNTIME_FFI_H
#endif
