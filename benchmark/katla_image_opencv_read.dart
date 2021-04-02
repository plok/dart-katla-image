import 'dart:core';
import 'package:dart_katla_image/dart_katla_image.dart';
import 'package:benchmark_harness/benchmark_harness.dart';
import './custom_emitter.dart';
import 'package:dart_katla_image/src/image.dart';

// Create a new benchmark by extending BenchmarkBase
class KatlaImageOpencvReadBenchmark extends BenchmarkBase {
  KatlaImageOpencvReadBenchmark() : super('KatlaImageOpencvReadBenchmark', emitter: CustomEmitter());

  static void main() {
    KatlaImageOpencvReadBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
    for(var i =0; i < 10; i++) {
      var image = Image.read('lenna.png');
      var _ = image.stride;
    }
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    run();
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() { }
}
