import 'dart:core';
import 'package:dart_katla_image/dart_katla_image.dart';
import 'package:benchmark_harness/benchmark_harness.dart';
import './custom_emitter.dart';

// Create a new benchmark by extending BenchmarkBase
class KatlaImageOpencvRoiWriteBenchmark extends BenchmarkBase {
  KatlaImageOpencvRoiWriteBenchmark() : super('KatlaImageOpencvRoiWriteBenchmark', emitter: CustomEmitter());

  Image? _origImage;
  Image? _roiImage;

  static void main() {
    KatlaImageOpencvRoiWriteBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
      if(_origImage == null || _roiImage == null) {
        print("failed!");
        return;
      }
      
      _roiImage!.writeSync('lenna-out.png');
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    _origImage = Image.read('lenna.png');
    if (_origImage == null) {
      return;
    }

    _roiImage = Image.createFromExistingRoi(_origImage!, Rect(10,10,100,100));

    run();
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() { }
}
