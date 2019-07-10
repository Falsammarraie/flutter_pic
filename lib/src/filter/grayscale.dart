import '../colorAdvanced.dart';
import '../pic.dart';

/// Convert the image to grayscale.
Pic grayscale(Pic src) {
  var p = src.getBytes();
  for (int i = 0, len = p.length; i < len; i += 4) {
    int l = getLuminanceRgb(p[i], p[i + 1], p[i + 2]);
    p[i] = l;
    p[i + 1] = l;
    p[i + 2] = l;
  }
  return src;
}
