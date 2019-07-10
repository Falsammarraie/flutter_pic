import 'dart:io';
import 'package:Pic/Pic.dart';

void main() {
  List<int> bytes = File('test/res/exr/grid.exr').readAsBytesSync();

  ExrDecoder dec = ExrDecoder();
  dec.startDecode(bytes);
  Pic img = dec.decodeFrame(0);

  List<int> png = PngEncoder().encodeImage(img);
  new File('out/exr/grid.png')
    ..createSync(recursive: true)
    ..writeAsBytesSync(png);
}
