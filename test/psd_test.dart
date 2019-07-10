import 'dart:io';
import 'package:Pic/Pic.dart';
import 'package:test/test.dart';

void main() {
  Directory dir = Directory('test/res/psd');
  var files = dir.listSync();

  group('PSD', () {
    for (var f in files) {
      if (f is! File || !f.path.endsWith('.psd')) {
        continue;
      }

      String name = f.path.split(RegExp(r'(/|\\)')).last;
      test(name, () {
        print('Decoding $name');

        Pic psd = PsdDecoder().decodeImage((f as File).readAsBytesSync());

        if (psd != null) {
          List<int> outPng = PngEncoder().encodeImage(psd);
          File('out/psd/$name.png')
            ..createSync(recursive: true)
            ..writeAsBytesSync(outPng);
        } else {
          throw 'Unable to decode $name';
        }
      });
    }
  });
}
