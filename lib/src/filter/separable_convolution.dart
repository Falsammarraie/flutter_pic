import '../pic.dart';
import 'separable_kernel.dart';

/// Apply a generic separable convolution filter the [src] image, using the
/// given [kernel].
///
/// [gaussianBlur] is an example of such a filter.
Pic separableConvolution(Pic src, SeparableKernel kernel) {
  // Apply the filter horizontally
  Pic tmp = Pic.from(src);
  kernel.apply(src, tmp, horizontal: true);

  // Apply the filter vertically, applying back to the original image.
  kernel.apply(tmp, src, horizontal: false);

  return src;
}
