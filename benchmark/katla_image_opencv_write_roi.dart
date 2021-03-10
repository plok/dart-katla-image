import 'dart:core';
import 'dart:ffi';
import 'package:dart_katla_image/dart_katla_image.dart';
import 'package:dart_katla_image/src/image_ffi.dart';
import 'package:ffi/ffi.dart';
import 'package:benchmark_harness/benchmark_harness.dart';
import './custom_emitter.dart';

// Create a new benchmark by extending BenchmarkBase
class KatlaImageOpencvRoiWriteBenchmark extends BenchmarkBase {
  KatlaImageOpencvRoiWriteBenchmark() : super('KatlaImageOpencvRoiWriteBenchmark', emitter: CustomEmitter());

  ImageBinding? _lib;
  Pointer<Void>? _origImage;
  Pointer<Void>? _image;

  static void main() {
    KatlaImageOpencvRoiWriteBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
      if(_origImage == null || _image == null) {
        print("failed!");
        return;
      }
      

      var destPath ='lenna-out.png'.toNativeUtf8();
      _lib!.write_image_sync(destPath.cast(), _image!);
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {
    var dll = DynamicLibrary.open('libkatla-image.so');
    _lib = ImageBinding(dll);

    var strPath = 'lenna.png'.toNativeUtf8();

    _origImage = _lib!.read_image(strPath.cast());
    if (_origImage == null) {
      return;
    }

    var rect = calloc<Rect_32s>().ref;
    rect.left = 10;
    rect.top = 10; 
    rect.right = 100;
    rect.bottom = 100;

    _image = _lib!.create_image_from_existing_roi(_origImage!, rect);

    run();
  }

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() { }
}
