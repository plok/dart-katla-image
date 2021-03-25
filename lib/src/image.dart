import 'dart:ffi';
import 'dart:isolate';
import 'dart:async';
import 'package:ffi/ffi.dart';
import 'image_ffi.dart';

class Size {
  int width;
  int height;

  Size(this.width, this.height);
}

class Rect {
  int left;
  int top;
  int right;
  int bottom;

  Rect(this.left, this.top, this.right, this.bottom);
}

class ImageFactory {
  static final ImageFactory _instance = ImageFactory._factory();

  late DynamicLibrary _lib;
  late ImageBinding binding;

  factory ImageFactory() {
    return _instance;
  }

  ImageFactory._factory() {
    _lib = DynamicLibrary.open("libkatla-dart.so");
    binding = ImageBinding(_lib);

    if (binding.dart_init_ffi(NativeApi.initializeApiDLData) != 0) {
      throw "Failed to initialize Dart API";
    }
  }
}

class Image {

  late Pointer<Void> _image;

  Size get size {
    var nativeWith = ImageFactory().binding.dart_image_width(_image);
    var nativeHeight = ImageFactory().binding.dart_image_height(_image);

    return Size(nativeWith,nativeHeight);
  }

  int get stride => ImageFactory().binding.image_line_stride(_image);
  int get channels => ImageFactory().binding.image_channels(_image);

  Image.create(Size size, {int channels = 4, int depth = 8}) {
    var nativeSize = calloc<Size_32s>().ref;
    nativeSize.width = size.width;
    nativeSize.height = size.height;
    _image = ImageFactory().binding.create_image(nativeSize, channels, depth);
  }

  Image.createWithStep(Size size, int step, {int channels = 4, int depth = 8}) {
    var nativeSize = calloc<Size_32s>().ref;
    nativeSize.width = size.width;
    nativeSize.height = size.height;
    _image = ImageFactory().binding.create_image_with_step(nativeSize, channels, step, depth);
  }

  Image.createFromExistingPixels(Pointer<Uint8> pixels, Size size, int step, {int channels = 4, int depth = 8}) {
    var nativeSize = calloc<Size_32s>().ref;
    nativeSize.width = size.width;
    nativeSize.height = size.height;
    _image = ImageFactory().binding.create_image_from_existing_pixels(pixels, nativeSize, channels, step, depth);
  }

  Image.createFromExistingRoi(Image src, Rect roi) {
    var nativeRoi = calloc<Rect_32s>().ref;
    nativeRoi.left = roi.left;
    nativeRoi.top = roi.top;
    nativeRoi.right = roi.right;
    nativeRoi.bottom = roi.bottom;

    _image = ImageFactory().binding.create_image_from_existing_roi(src._image, nativeRoi);
  }

  Image.read(String path) {
    _image = ImageFactory().binding.read_image(path.toNativeUtf8().cast());
  }

  void writeSync(String path) {
    ImageFactory().binding.write_image_sync(path.toNativeUtf8().cast(), _image);
  }

  Future<void> write(String path) async {

    var completer = Completer<void>();

    var receivePort = ReceivePort()
      ..listen((data) {
        completer.complete();
      });

    ImageFactory().binding.dart_write_image(path.toNativeUtf8().cast(), _image, receivePort.sendPort.nativePort);

    return completer.future;
  }

  void splitSync(List<Image> dest) {
    final Pointer<Pointer<Void>> pointerPointer =
      calloc.allocate(sizeOf<Pointer<Void>>() * dest.length);

    try {
      for(var i=0; i<dest.length; i++) {
        pointerPointer[i] = dest[i]._image;
      }
    
      ImageFactory().binding.split(_image, pointerPointer);
    } finally {
      calloc.free(pointerPointer);
    }

  }

  void dispose() {
    ImageFactory().binding.destroy_image(_image);
  }
}

