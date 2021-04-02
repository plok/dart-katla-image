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

  Image? _image;

  static void main() {
    KatlaImageOpencvWriteBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
      for(var i = 0; i < 10; i++) {
        _image!.writeSync('lenna-out.png');
      }
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    _image = Image.read('lenna.png');

    run();
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() { }
}
