import 'dart:io';
import 'package:dart_katla_image/dart_katla_image.dart';
import 'package:test/test.dart';

void main() {
  group('Image test: ', () {
    
    setUp(() {

    });

    test('read image', () {
      var image = Image.read("lenna.png");
      print (image.stride);
      expect(image.stride, equals(2048));
    });

    test('synchronous write image', () {
      var image = Image.read("lenna.png");
      print (image.stride);
      expect(image.stride, equals(2048));

      File('lenna-out.png').deleteSync();
      image.writeSync("lenna-out.png");

      var outFile = File('lenna-out.png');
      var exists = outFile.existsSync();
      expect(exists, equals(true));
    });

    test('async write image', () async {
      var image = Image.read("lenna.png");
      print (image.stride);
      expect(image.stride, equals(2048));

      await File('lenna-out.png').delete();
      await image.write("lenna-out.png");

      var outFile = File('lenna-out.png');
      var exists = await outFile.exists();
      expect(exists, equals(true));
    });

  });
}
