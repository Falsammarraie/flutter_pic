import '../pic.dart';
import 'convolution.dart';

/// Apply an emboss convolution filter.
Pic emboss(Pic src) {
  const filter = [1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.5];

  return convolution(src, filter, div: 1, offset: 127);
}
