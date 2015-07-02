library color_props_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';

import 'prop_utils.dart';

import 'dart:collection' show MapView;

main() {
  group('ColorProps', () {
    ColorPropsTest instance;
    setUp(() {
      instance = new ColorPropsTest({});
    });

    test('backgroundColor', () {
      testProp(#backgroundColor, ColorProps.Z_$KEY__BACKGROUND_COLOR, instance, BackgroundColor.ALTERNATE);
    });

    test('borderColor', () {
      testProp(#borderColor, ColorProps.Z_$KEY__BORDER_COLOR, instance, BorderColor.ALTERNATE);
    });

    test('textColor', () {
      testProp(#textColor, ColorProps.Z_$KEY__TEXT_COLOR, instance, TextColor.ALTERNATE);
    });
  });
}

class ColorPropsTest extends MapView with ColorProps {
  /// Create a new instance backed by the specified map.
  ColorPropsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}
