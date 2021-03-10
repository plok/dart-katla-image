import 'dart:core';
import 'dart:ffi';
import 'package:dart_katla_image/dart_katla_image.dart';
import 'package:ffi/ffi.dart';
import 'package:benchmark_harness/benchmark_harness.dart';
import './custom_emitter.dart';
import 'package:dart_katla_image/src/image_ffi.dart';

// Create a new benchmark by extending BenchmarkBase
class KatlaImageOpencvWriteBenchmark extends BenchmarkBase {
  KatlaImageOpencvWriteBenchmark() : super('KatlaImageOpencvWriteBenchmark', emitter: CustomEmitter());

  ImageBinding? _lib;
  Pointer<Void>? _image;

  static void main() {
    KatlaImageOpencvWriteBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
      var destPath ='lenna-out.png'.toNativeUtf8();
      _lib!.write_image_sync(destPath.cast(), _image!);
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    var dll = DynamicLibrary.open('libkatla-image.so');
    _lib = ImageBinding(dll);

    var strPath = 'lenna.png'.toNativeUtf8();

    _image = _lib!.read_image(strPath.cast());

    run();
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() { }
}
