part of bot.math;

// shamelessly starting with
// http://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/ui_lib/base/Size.dart?r=4154

class Size {
  final num width, height;

  const Size(this.width, this.height);

  @override
  bool operator ==(other) {
    return other is Size && width == other.width && height == other.height;
  }

  /**
   * Returns the area of the size (width * height).
   */
  num get area => width * height;

  /**
   * Returns the ratio of the size's width to its height.
   */
  num get aspectRatio => width / height;

  /**
   * Returns true if this Size is the same size or smaller than the
   * [target] size in both dimensions.
   */
  bool fitsInside(Size target) {
    return width <= target.width && height <= target.height;
  }

  /**
   * Returns true if the size has zero area, false if both dimensions
   *     are non-zero numbers.
   */
  bool isEmpty() => area == 0;

  /**
   * Returns the perimeter of the size (width + height) * 2.
   */
  num get perimeter => (width + height) * 2;

  bool get isValid => isValidNumber(width) && isValidNumber(height) &&
      width >= 0 && height >= 0;

  /**
   * Multiplies each dimensions by the provided magnitude and returns a new [Size].
   **/
  Size scale(num magnitude) => new Size(width * magnitude, height * magnitude);

  /**
   * Multiplies each dimensions by the provided magnitude and returns a new [Size].
   **/
  Size operator *(num magnitude) => this.scale(magnitude);

  Vector toVector() => new Vector(width, height);

  /**
   * Returns a nice string representing size.
   * Returns in the form (50 x 73).
   */
  @override
  String toString() => "(${width} x ${height})";

  int get hashCode => Util.getHashCode([width, height]);
}
