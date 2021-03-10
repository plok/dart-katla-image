import 'dart:core';
import 'dart:ffi';
import 'package:dart_katla_image/dart_katla_image.dart';
import 'package:ffi/ffi.dart';
import 'package:benchmark_harness/benchmark_harness.dart';
import './custom_emitter.dart';
import 'package:dart_katla_image/src/image_ffi.dart';

// Create a new benchmark by extending BenchmarkBase
class KatlaImageOpencvReadBenchmark extends BenchmarkBase {
  KatlaImageOpencvReadBenchmark() : super('KatlaImageOpencvReadBenchmark', emitter: CustomEmitter());

  ImageBinding? _lib;

  static void main() {
    KatlaImageOpencvReadBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
      var strPath = 'lenna.png'.toNativeUtf8();

      var image = _lib!.read_image(strPath.cast());
      var _ = _lib!.image_line_stride(image);
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    var dll = DynamicLibrary.open('libkatla-image.so');
    _lib = ImageBinding(dll);

    run();
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() { }
}