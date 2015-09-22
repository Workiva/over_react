library color_props_test;

import 'dart:collection' show MapView;

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../../test_util/prop_utils.dart';

main() {
  group('The ColorProps prop', () {
    ColorPropsTest instance;
    setUp(() {
      instance = new ColorPropsTest({});
    });

    test('backgroundColor is able to have its value set and read', () {
      testProp(#backgroundColor, ColorProps.Z_$KEY__BACKGROUND_COLOR, instance, BackgroundColor.ALTERNATE);
    });

    test('borderColor is able to have its value set and read', () {
      testProp(#borderColor, ColorProps.Z_$KEY__BORDER_COLOR, instance, BorderColor.ALTERNATE);
    });

    test('textColor is able to have its value set and read', () {
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
