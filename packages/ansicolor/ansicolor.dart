///
/// Copyright 2013 Google Inc. All Rights Reserved.
///
/// ANSI/XTERM SGR (Select Graphics Rendering) support for 256 colors.
/// Note: if you're using the dart editor, these won't look right in the
/// terminal; disable via [color_disabled] or use Eclipse with the Dart and
/// AnsiConsol plugins!
///
library ansicolor;

/**
 *  Globally enable or disable [AnsiPen] settings
 *  Handy for turning on and off embedded colors without commenting out code.
 */
bool color_disabled = false;


/**
 * Pen attributes for foreground and background colors.
 * Use the pen in string interpolation to output ansi codes.
 * Use [up] in string interpolation to globally reset colors.
 */
class AnsiPen {

  /**
   * Treat a pen instance as a function such that pen("msg") is the same as
   * pen.write("msg").
   */
  call(String msg) => write(msg);

  /**
   * Allow pen colors to be used in a string.
   * Note: Once the pen is down, its attributes remain in effect till they are
   * changed by another pen or [up].
   */
  String toString() {
    if (color_disabled) return "";
    if (_pen != null) return _pen;

    StringBuffer sb = new StringBuffer();
    if (_fcolor != null) {
      sb.write("${ANSI_ESC}38;5;${_fcolor}m");
    }

    if (_bcolor != null) {
      sb.write("${ANSI_ESC}48;5;${_bcolor}m");
    }

    _pen = sb.toString();
    return _pen;
  }

  /**
   * Return control codes to change the terminal colors.
   */
  String get down => this.toString();

  /**
   * Reset all pen attributes in the terminal.
   */
  String get up => color_disabled ? "" : ANSI_DEFAULT;

  /**
   * Write the [msg] with the pen's current settings and then reset all
   * attributes.
   */
  String write(String msg) => "${this}$msg$up";

  black({bool bg: false, bool bold: false})    => _std(0, bold, bg);
  red({bool bg: false, bool bold: false})      => _std(1, bold, bg);
  green({bool bg: false, bool bold: false})    => _std(2, bold, bg);
  yellow({bool bg: false, bool bold: false})   => _std(3, bold, bg);
  blue({bool bg: false, bool bold: false})     => _std(4, bold, bg);
  magenta({bool bg: false, bool bold: false})  => _std(5, bold, bg);
  cyan({bool bg: false, bool bold: false})     => _std(6, bold, bg);
  white({bool bg: false, bool bold: false})    => _std(7, bold, bg);

  /**
   * Set the pen color to the rgb value between 0.0..1.0
   */
  rgb({r: 1.0, g: 1.0, b: 1.0, bool bg: false}) =>
    xterm(
        (r.clamp(0.0, 1.0) * 5).toInt() * 36 +
        (g.clamp(0.0, 1.0) * 5).toInt() * 6 +
        (b.clamp(0.0, 1.0) * 5).toInt() + 16,
        bg: bg);

  /**
   * See the pen color to a grey scale value between 0.0 and 1.0
   */
  gray({level: 1.0, bool bg: false}) =>
      xterm(232 + (level.clamp(0.0, 1.0) * 23).round(), bg: bg);

  _std(int color, bool bold, bool bg) => xterm(color + (bold ? 8 : 0), bg: bg);

  /**
   * Directly index the xterm 256 color palette.
   */
  xterm(int color, {bool bg: false}) {
    _pen = null;
    var c = color.toInt().clamp(0, 256);
    if (bg) {
      _bcolor = c;
    } else {
      _fcolor = c;
    }
  }

  /**
   * Reset the pen's attributes.
   */
  reset() {
    _pen = null;
    _bcolor = _fcolor = null;
  }

  int _fcolor;
  int _bcolor;
  String _pen;
}


/**
 *  ANSI Control Sequence Introducer, signals the terminal for new settings.
 */
String get ANSI_ESC => color_disabled ? "" : '\x1B[';


/**
 *  Reset all colors and options for current SGRs to terminal defaults.
 */
String get ANSI_DEFAULT => color_disabled ? "" : "${ANSI_ESC}0m";


/**
 * Defaults the terminal's foreground color without altering the background.
 * Does not modify [AnsiPen]!
 */
String resetForeground() => "${ANSI_ESC}39m";


/**
 * Defaults the terminal's background color without altering the foreground.
 * Does not modify [AnsiPen]!
 */
String resetBackground() => "${ANSI_ESC}49m";


/**
 * Due to missing sprintf(), this is my cheap "%03d".
 */
String _toSpace(int i, [int width = 3]) {
  if (width <= 0 && i == 0) return "";
  return "${_toSpace(i ~/ 10, --width)}${i % 10}";
}

/**
 * Return a reference table for foreground and background colors.
 */
String ansi_demo() {
  StringBuffer sb = new StringBuffer();

  AnsiPen pen = new AnsiPen();

  for (int c = 0; c < 16; c++) {
    pen..reset()..white(bold: true)..xterm(c, bg: true);
    sb.write(pen("${_toSpace(c)} "));
    pen..reset()..xterm(c);
    sb.write(pen(" ${_toSpace(c)} "));
    if (c == 7 || c == 15) {
      sb.write("\n");
    }
  }

  for (int r = 0; r < 6; r++) {
    sb.write("\n");
    for (int g = 0; g < 6; g++) {
      for (int b = 0; b < 6; b++) {
        var c = r*36 + g*6 + b + 16;
        pen..reset()..rgb(r: r / 5, g: g / 5, b: b / 5, bg: true)..
            white(bold: true);
        sb.write(pen(" ${_toSpace(c)} "));
        pen..reset()..rgb(r: r / 5, g: g / 5, b: b / 5);
        sb.write(pen(" ${_toSpace(c)} "));
      }
      sb.write("\n");
    }
  }

  for (int c = 0; c < 24; c++) {
    if (0 == c % 8) {
      sb.write("\n");
    }
    pen..reset()..gray(level: c / 23, bg: true)..white(bold:true);
    sb.write(pen(" ${_toSpace(c + 232)} "));
    pen..reset()..gray(level: c / 23);
    sb.write(pen(" ${_toSpace(c + 232)} "));
  }
  return sb.toString();
}
