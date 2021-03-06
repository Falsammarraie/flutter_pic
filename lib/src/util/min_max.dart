import '../colorAdvanced.dart';
import '../pic.dart';

/// Find the minimum and maximum color value in the image.
/// Returns a list as <[min], [max]>.
List<int> minMax(Pic image) {
  int min = 255;
  int max = 0;
  final int len = image.length;
  for (int i = 0; i < len; ++i) {
    int c = image[i];
    int r = getRed(c);
    int g = getGreen(c);
    int b = getBlue(c);

    if (r < min) {
      min = r;
    }
    if (r > max) {
      max = r;
    }
    if (g < min) {
      min = g;
    }
    if (g > max) {
      max = g;
    }
    if (b < min) {
      min = b;
    }
    if (b > max) {
      max = b;
    }
    if (image.channels == Channels.rgba) {
      int a = getAlpha(c);
      if (a < min) {
        min = a;
      }
      if (a > max) {
        max = a;
      }
    }
  }

  return [min, max];
}
