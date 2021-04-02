import 'dart:core';
import 'dart:io';
import 'package:image/image.dart' as ImageLib;
import 'package:benchmark_harness/benchmark_harness.dart';
import './custom_emitter.dart';

// Create a new benchmark by extending BenchmarkBase
class PackageImageReadBenchmark extends BenchmarkBase {
  PackageImageReadBenchmark() : super('PackageImageReadBenchmark', emitter: CustomEmitter());

  static void main() {
    PackageImageReadBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
    for(var i = 0; i < 10; i++) {
      var path = 'lenna.png';
        
      var file = File(path);
        
      var fileBytes = file.readAsBytesSync();
      var image = ImageLib.decodeImage(fileBytes);
      var _ = image!.numberOfChannels * image.width;
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
