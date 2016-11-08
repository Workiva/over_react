part of bot.color;

// shamelessly borrowed from https://github.com/boronine/husl
// On 2012-07-05
// Commit: 501439fc483a283838b299b8973a47a5a437942b, June 27
class HuslConverter {

  //Pass in HUSL values and get back RGB values
  //  H ranges from 0 to 360, S and L from 0 to 100.
  //RGB values will range from 0 to 1.
  static List<num> HUSLtoRGB(num h, num s, num l) {
    return _XYZ_RGB(_LUV_XYZ(_LCH_LUV(_HUSL_LCH([h, s, l]))));
  }

  //Pass in RGB values ranging from 0 to 1 and get back HUSL values.
  //H ranges from 0 to 360, S and L from 0 to 100.
  static List<num> RGBtoHUSL(num r, num g, num b) {
    return _LCH_HUSL(_LUV_LCH(_XYZ_LUV(_RGB_XYZ([r, g, b]))));
  }

  static List<List<num>> get m {
    return [[3.2406, -1.5372, -0.4986],
            [-0.9689, 1.8758, 0.0415],
            [0.0557, -0.2040, 1.0570]];
  }

  static List<List<num>> get m_inv {
    return [[0.4124, 0.3576, 0.1805],
            [0.2126, 0.7152, 0.0722],
            [0.0193, 0.1192, 0.9505]];
  }

  static final num refX = 0.95047;
  static final num refY = 1.00000;
  static final num refZ = 1.08883;
  static final num refU = 0.19784;
  static final num refV = 0.46834;
  static final num lab_e = 0.008856;
  static final num lab_k = 903.3;

  static num _maxChroma(num L, num H) {
    final List<num> _ref = [0.0, 1.0];

    final hrad = ((H / 360.0) * 2 * math.PI);
    final sinH = math.sin(hrad);
    final cosH = math.cos(hrad);
    final sub1 = math.pow(L + 16, 3) / 1560896.0;
    final sub2 = sub1 > 0.008856 ? sub1 : (L / 903.3);
    var result = double.INFINITY;
    for (var _i = 0; _i < 3; _i++) {
      final row = m[_i];
      final m1 = row[0];
      final m2 = row[1];
      final m3 = row[2];
      final top = ((0.99915 * m1 + 1.05122 * m2 + 1.14460 * m3) * sub2);
      final rbottom = (0.86330 * m3 - 0.17266 * m2);
      final lbottom = (0.12949 * m3 - 0.38848 * m1);
      final bottom = (rbottom * sinH + lbottom * cosH) * sub2;

      for (var _j = 0; _j < 2; _j++) {
        final t = _ref[_j];
        final C = (L * (top - 1.05122 * t) / (bottom + 0.17266 * sinH * t));
        if ((C > 0 && C < result)) {
          result = C;
        }
      }
    }
    return result;
  }

  static num _dotProduct(List<num> a, List<num> b) {
    assert(a.length == b.length);

    num ret = 0.0;
    for (var i = 0; i < a.length; i++) {
      ret += a[i] * b[i];
    }
    return ret;
  }

  static num _round(num number, int places) {
    final n = math.pow(10.0, places);
    return (number * n).floor() / n;
  }

  static num _f(num t) {
    if (t > lab_e) {
      return math.pow(t, 1.0 / 3.0);
    } else {
      return 7.787 * t + 16 / 116.0;
    }
  }

  static num _f_inv(num t) {
    if (math.pow(t, 3) > lab_e) {
      return math.pow(t, 3);
    } else {
      return (116 * t - 16) / lab_k;
    }
  }

  static num _fromLinear(num c) {
    if (c <= 0.0031308) {
      return 12.92 * c;
    } else {
      return (1.055 * math.pow(c, 1 / 2.4) - 0.055);
    }
  }

  static num _toLinear(num c) {
    final a = 0.055;

    if (c > 0.04045) {
      return math.pow((c + a) / (1 + a), 2.4);
    } else {
      return (c / 12.92);
    }
  }

  static List<num> _rgbPrepare(List<num> tuple) {
    for (var i = 0; i < 3; ++i) {
      tuple[i] = _round(tuple[i], 3);

      if (tuple[i] < 0 || tuple[i] > 1) {
        if (tuple[i] < 0) {
          tuple[i] = 0;
        } else {
          tuple[i] = 1;
        }
      }
      tuple[i] = _round(tuple[i] * 255, 0);
    }

    return tuple;
  }

  static List<num> _XYZ_RGB(List<num> tuple) {
    final R = _fromLinear(_dotProduct(m[0], tuple));
    final G = _fromLinear(_dotProduct(m[1], tuple));
    final B = _fromLinear(_dotProduct(m[2], tuple));

    tuple[0] = R;
    tuple[1] = G;
    tuple[2] = B;

    return tuple;
  }

  static List<num> _RGB_XYZ(List<num> tuple) {
    final R = tuple[0];
    final G = tuple[1];
    final B = tuple[2];

    final rgbl = [_toLinear(R), _toLinear(G), _toLinear(B)];

    final X = _dotProduct(m_inv[0], rgbl);
    final Y = _dotProduct(m_inv[1], rgbl);
    final Z = _dotProduct(m_inv[2], rgbl);

    tuple[0] = X;
    tuple[1] = Y;
    tuple[2] = Z;

    return tuple;
  }

  static List<num> _XYZ_LUV(List<num> tuple) {
    final X = tuple[0];
    final Y = tuple[1];
    final Z = tuple[2];

    final varU = (4 * X) / (X + (15.0 * Y) + (3 * Z));
    final varV = (9 * Y) / (X + (15.0 * Y) + (3 * Z));
    final L = 116 * _f(Y / refY) - 16;
    final U = 13 * L * (varU - refU);
    final V = 13 * L * (varV - refV);

    tuple[0] = L;
    tuple[1] = U;
    tuple[2] = V;

    return tuple;
  }

  static List<num> _LUV_XYZ(List<num> tuple) {
    final L = tuple[0];
    final U = tuple[1];
    final V = tuple[2];

    if (L == 0) {
      tuple[2] = tuple[1] = tuple[0] = 0.0;
      return tuple;
    }

    final varY = _f_inv((L + 16) / 116.0);
    final varU = U / (13.0 * L) + refU;
    final varV = V / (13.0 * L) + refV;
    final Y = varY * refY;
    final X = 0 - (9 * Y * varU) / ((varU - 4.0) * varV - varU * varV);
    final Z = (9 * Y - (15 * varV * Y) - (varV * X)) / (3.0 * varV);

    tuple[0] = X;
    tuple[1] = Y;
    tuple[2] = Z;

    return tuple;
  }

  static List<num> _LUV_LCH(List<num> tuple) {
    final L = tuple[0];
    final U = tuple[1];
    final V = tuple[2];

    final C = (math.pow(math.pow(U, 2) + math.pow(V, 2), (1 / 2.0)));
    final Hrad = (math.atan2(V, U));
    var H = (Hrad * 360.0 / 2.0 / math.PI);
    if (H < 0) {
      H = 360 + H;
    }

    tuple[0] = L;
    tuple[1] = C;
    tuple[2] = H;

    return tuple;
  }

  static List<num> _LCH_LUV(List<num> tuple) {
    final L = tuple[0];
    final C = tuple[1];
    final H = tuple[2];

    final Hrad = H / 360.0 * 2.0 * math.PI;
    final U = math.cos(Hrad) * C;
    final V = math.sin(Hrad) * C;

    tuple[0] = L;
    tuple[1] = U;
    tuple[2] = V;

    return tuple;
  }

  static List<num> _HUSL_LCH(List<num> tuple) {
    final H = tuple[0];
    final S = tuple[1];
    final L = tuple[2];

    final max = _maxChroma(L, H);
    final C = max / 100.0 * S;

    tuple[0] = L;
    tuple[1] = C;
    tuple[2] = H;

    return tuple;
  }

  static List<num> _LCH_HUSL(List<num> tuple) {
    final L = tuple[0];
    final C = tuple[1];
    final H = tuple[2];

    final max = _maxChroma(L, H);
    final S = C / max * 100;

    tuple[0] = H;
    tuple[1] = S;
    tuple[2] = L;

    return tuple;
  }
}
