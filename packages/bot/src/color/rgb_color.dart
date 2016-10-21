part of bot.color;

// RGB-HSL conversion logic borrowed with love from Google Closure Library
// http://code.google.com/p/closure-library/source/browse/trunk/closure/goog/color/color.js

class RgbColor {
  final int r, g, b;

  const RgbColor._internal(this.r, this.g, this.b);

  factory RgbColor(int r, int g, int b) {
    _validateComponent(r, 'r');
    _validateComponent(g, 'g');
    _validateComponent(b, 'b');

    return new RgbColor._internal(r, g, b);
  }

  factory RgbColor.fromHex(String hexColor) {
    requireArgumentNotNull(hexColor, 'hexColor');
    hexColor = _normalizeHex(hexColor);
    var r = int.parse('0x' + hexColor.substring(1, 3));
    var g = int.parse('0x' + hexColor.substring(3, 5));
    var b = int.parse('0x' + hexColor.substring(5, 7));

    return new RgbColor(r, g, b);
  }

  String toHex() {
    final buffer = new StringBuffer('#');
    [r, g, b].forEach((c) {
      buffer.write(_prependZeroIfNecessaryHelper(c.toRadixString(16)));
    });
    return buffer.toString();
  }

  HslColor toHsl() {
    // First must normalize r, g, b to be between 0 and 1.
    final normR = r / 255;
    final normG = g / 255;
    final normB = b / 255;
    final max = math.max(normR, math.max(normG, normB));
    final min = math.min(normR, math.min(normG, normB));
    // Luminosity is the average of the max and min rgb color intensities.
    final l = 0.5 * (max + min);

    double h = 0.0;
    double s = 0.0;

    // The hue and saturation are dependent on which color intensity is the max.
    // If max and min are equal, the color is gray and h and s should be 0.
    if (max != min) {
      if (max == normR) {
        h = 60 * (normG - normB) / (max - min);
      } else if (max == normG) {
        h = 60 * (normB - normR) / (max - min) + 120;
      } else if (max == normB) {
        h = 60 * (normR - normG) / (max - min) + 240;
      }

      if (0 < l && l <= 0.5) {
        s = (max - min) / (2 * l);
      } else {
        s = (max - min) / (2 - 2 * l);
        // handle a nice case where s can be just over 1
        s = math.min(1.0, s);
      }
    }

    return new HslColor(h, s, l);
  }

  int get hashCode => Util.getHashCode([r, g, b]);

  bool operator ==(other) {
    return other is RgbColor && other.r == r && other.g == g && other.b == b;
  }

  String toString() => '{RgbColor: $r, $g, $b}';

  static void _validateComponent(int c, String name) {
    requireArgument(isValidNumber(c), name);
    requireArgument(c >= 0 && c <= 255, name);
  }

  static String _prependZeroIfNecessaryHelper(String hex) {
    return hex.length == 1 ? '0' + hex : hex;
  }

  // TODO: support colors in the format #rgb
  //       right now we only support #rrggbb
  static String _normalizeHex(String hexColor) {
    requireArgument(_isValidHexColor(hexColor), 'hexColor',
        "'$hexColor' is not a valid hex color");
    return hexColor.toLowerCase();
  }

  static final RegExp _validHexColorRe =
      new RegExp('^#(?:[0-9a-f]{6})\$', multiLine: false, caseSensitive: false);

  static bool _isValidHexColor(String str) {
    return _validHexColorRe.hasMatch(str);
  }
}
