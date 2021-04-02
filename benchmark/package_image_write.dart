import 'dart:core';
import 'dart:io';
import 'package:image/image.dart' as ImageLib;
import 'package:benchmark_harness/benchmark_harness.dart';
import './custom_emitter.dart';

// Create a new benchmark by extending BenchmarkBase
class PackageImageWriteBenchmark extends BenchmarkBase {
  PackageImageWriteBenchmark() : super('PackageImageWriteBenchmark', emitter: CustomEmitter());

  ImageLib.Image? _image;

  static void main() {
    PackageImageWriteBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
      for(var i = 0; i < 10; i++) {
        var file = File('lenna-out.png');
        file.createSync(recursive: true);

        var pngBytes = ImageLib.encodePng(_image!);
        file.writeAsBytesSync(pngBytes, flush: false);
      }      
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    var path = 'lenna.png';
      
    var file = File(path);
    var fileBytes = file.readAsBytesSync();
    _image = ImageLib.decodeImage(fileBytes);

    run();
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() { }
}