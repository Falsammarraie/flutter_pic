import '../pic.dart';

/// Returns a cropped copy of [src].
Pic copyCrop(Pic src, int x, int y, int w, int h) {
  Pic dst = Pic(w, h, channels: src.channels, exif: src.exif, iccp: src.iccProfile);

  for (int yi = 0, sy = y; yi < h; ++yi, ++sy) {
    for (int xi = 0, sx = x; xi < w; ++xi, ++sx) {
      dst.setPixel(xi, yi, src.getPixel(sx, sy));
    }
  }

  return dst;
}
