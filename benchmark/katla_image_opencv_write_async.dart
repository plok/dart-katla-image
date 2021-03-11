import 'dart:core';
import 'dart:ffi';
import 'dart:async';
import 'package:dart_katla_image/dart_katla_image.dart';
import 'package:ffi/ffi.dart';
import 'package:benchmark_harness/benchmark_harness.dart';
import './custom_emitter.dart';
import './benchmark_base_async.dart';
import 'package:dart_katla_image/src/image_ffi.dart';

// Create a new benchmark by extending BenchmarkBase
class KatlaImageOpencvWriteAsyncBenchmark extends BenchmarkBaseAsync {
  KatlaImageOpencvWriteAsyncBenchmark() : super('KatlaImageOpencvWriteAsyncBenchmark', emitter: CustomEmitter());

  Image? _image;

  // The benchmark code.
  @override
  Future<void> run() async {
    for(var i = 0; i < 10; i++) {
      await _image!.write('lenna-out.png');
    }
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  Future<void> setup() async {
    _image = Image.read('lenna.png');

    await run();
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() {
    _image!.dispose();
  }
}
