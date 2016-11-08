part of bot.color;

// RGB-HSL conversion logic borrowed with love from Google Closure Library
// http://code.google.com/p/closure-library/source/browse/trunk/closure/goog/color/color.js

class HslColor {
  final num h, s, l;

  const HslColor._internal(this.h, this.s, this.l);

  factory HslColor(num h, num s, num l) {
    requireArgument(isValidNumber(h), 'h', 'hue value was not valid');
    h = (h % 360);

    requireArgument(isValidNumber(s), 's', 'must be a valid number');
    requireArgument(s >= 0 && s <= 1, 's', 'must be >= 0 && <= 1 but was $s');
    requireArgument(isValidNumber(l), 'l', 'must be a valid number');
    requireArgument(l >= 0 && l <= 1, 'l', 'must be >= 0 && <=1 but was $l');

    return new HslColor._internal(h, s, l);
  }

  RgbColor toRgb() {
    final normH = h / 360; // normalize h to fall in [0, 1]

    num r, g, b;

    if (s == 0) {
      r = g = b = l * 255;
    } else {
      var temp1 = 0;
      var temp2 = 0;
      if (l < 0.5) {
        temp2 = l * (1 + s);
      } else {
        temp2 = l + s - (s * l);
      }
      temp1 = 2 * l - temp2;
      r = 255 * _hueToRgb(temp1, temp2, normH + (1 / 3));
      g = 255 * _hueToRgb(temp1, temp2, normH);
      b = 255 * _hueToRgb(temp1, temp2, normH - (1 / 3));
    }

    return new RgbColor(r.round().toInt(), g.round().toInt(), b.round().toInt());
  }

  int get hashCode => Util.getHashCode([h, s, l]);

  bool operator ==(other) {
    return other is HslColor && other.h == h && other.s == s && other.l == l;
  }

  String toString() => '{HslColor: $h, $s, $l}';

  static num _hueToRgb(num v1, num v2, num vH) {
    vH %= 1.0;

    if ((6 * vH) < 1) {
      return (v1 + (v2 - v1) * 6 * vH);
    } else if (2 * vH < 1) {
      return v2;
    } else if (3 * vH < 2) {
      return (v1 + (v2 - v1) * ((2 / 3) - vH) * 6);
    }
    return v1;
  }
}
