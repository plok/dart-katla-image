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
      expect(image.stride, equals(1536));
    });

    test('synchronous write image', () {
      var image = Image.read("lenna.png");
      print (image.stride);
      expect(image.stride, equals(1536));

      if (await File('lenna-out.png').exists()) {
        File('lenna-out.png').deleteSync();
      }
      image.writeSync("lenna-out.png");

      var outFile = File('lenna-out.png');
      var exists = outFile.existsSync();
      expect(exists, equals(true));
    });

    test('async write image', () async {
      var image = Image.read("lenna.png");
      print (image.stride);
      expect(image.stride, equals(1536));

      if (await File('lenna-out.png').exists()) {
        await File('lenna-out.png').delete();
      }
      await image.write("lenna-out.png");

      var outFile = File('lenna-out.png');
      var exists = await outFile.exists();
      expect(exists, equals(true));
    });

    test('split image', () async {
      var image = Image.read("lenna.png");
      print (image.stride);
      expect(image.stride, equals(1536));

      var rImage = Image.create(image.size, channels: 1);
      var gImage = Image.create(image.size, channels: 1);
      var bImage = Image.create(image.size, channels: 1);

      try {

        image.splitSync([rImage, gImage, bImage]);

        if (await File('lenna-out-r.tiff').exists()) {
          await File('lenna-out-r.tiff').delete();
        };
        await rImage.write("lenna-out-r.tiff");

        if (await File('lenna-out-g.tiff').exists()) {
          await File('lenna-out-g.tiff').delete();
        }
        await gImage.write("lenna-out-g.tiff");

        if (await File('lenna-out-b.tiff').exists()) {
          await File('lenna-out-b.tiff').delete();
        }
        await bImage.write("lenna-out-b.tiff");

        var rOutFile = File('lenna-out-r.tiff');
        var exists = await rOutFile.exists();
        expect(exists, equals(true));

        var gOutFile = File('lenna-out-g.tiff');
        exists = await gOutFile.exists();
        expect(exists, equals(true));

        var bOutFile = File('lenna-out-b.tiff');
        exists = await bOutFile.exists();
        expect(exists, equals(true));
      } finally {
        rImage.dispose();
        gImage.dispose();
        bImage.dispose();
        image.dispose();
      }
    });

  });
}
