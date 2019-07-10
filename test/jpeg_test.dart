import 'dart:io';
import 'package:Pic/pic.dart';
import 'package:test/test.dart';

void main() {
  var dir = Directory('test/res/jpg');
  var files = dir.listSync(recursive: true);

  group('JPEG', () {
    for (var f in files) {
      if (f is! File || !f.path.endsWith('.jpg')) {
        continue;
      }

      String name = f.path.split(new RegExp(r'(/|\\)')).last;
      test('$name', () {
        List<int> bytes = (f as File).readAsBytesSync();
        expect(new JpegDecoder().isValidFile(bytes), equals(true));

        Pic image = JpegDecoder().decodeImage(bytes);
        if (image == null) {
          throw new ImageException('Unable to decode JPEG Pic: $name.');
        }

        List<int> outJpg = JpegEncoder().encodeImage(image);
        new File('out/jpg/${name}')
          ..createSync(recursive: true)
          ..writeAsBytesSync(outJpg);

        // Make sure we can read what we just wrote.
        Pic image2 = JpegDecoder().decodeImage(outJpg);
        if (image2 == null) {
          throw new ImageException('Unable to re-decode JPEG Pic: $name.');
        }

        expect(image.width, equals(image2.width));
        expect(image.height, equals(image2.height));
      });
    }

    for (int i = 1; i < 9; ++i) {
      test('exif/orientation_$i/landscape', () {
        Pic image = JpegDecoder().decodeImage(new File('test/res/jpg/landscape_$i.jpg').readAsBytesSync());
        expect(image.exif.hasOrientation, equals(true));
        expect(image.exif.orientation, equals(i));
        new File('out/jpg/landscape_$i.png')
          ..createSync(recursive: true)
          ..writeAsBytesSync(new PngEncoder().encodeImage(bakeOrientation(image)));
      });

      test('exif/orientation_$i/portrait', () {
        Pic image = JpegDecoder().decodeImage(new File('test/res/jpg/portrait_$i.jpg').readAsBytesSync());
        expect(image.exif.hasOrientation, equals(true));
        expect(image.exif.orientation, equals(i));
        new File('out/jpg/portrait_$i.png')
          ..createSync(recursive: true)
          ..writeAsBytesSync(new PngEncoder().encodeImage(bakeOrientation(image)));
      });
    }
  });
}
