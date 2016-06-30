library rem_util_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'package:web_skin_dart/ui_core.dart';
import 'dart:html';
import 'package:web_skin_dart/src/ui_core/util/rem_util.dart';

/// Main entry point for RemUtil testing
main() {
  group('rem_util', () {
    void setRootFontSize(String value) {
      document.documentElement.style.fontSize = value;
      expect(document.documentElement.getComputedStyle().fontSize, value);
    }

    void unsetRootFontSize() {
      document.documentElement.style.fontSize = null;
    }

    group('toRem', () {
      setUp(() {
        setRootFontSize('20px');
      });

      tearDown(() {
        unsetRootFontSize();
      });

      test('converts a px CSS value to rem', () {
        expect(toRem('15px'), '0.75rem');
      });

      test('converts an int value (treated as px) to rem', () {
        expect(toRem(15), '0.75rem');
      });

      test('converts a double (treated as px) to rem', () {
        expect(toRem(20.2), '1.01rem');
      });

      test('throws when passed an invalid value', () {
        expect(() => toRem(new Object()), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a num or a String px value'))))
        );
      });

      test('throws when passed a malformed CSS value string', () {
        expect(() => toRem(''), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a num or a String px value'))))
        );
      });

      test('throws when passed a CSS value string with a unit other than px', () {
        expect(() => toRem('1em'), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a num or a String px value'))))
        );
      });
    });

    group('toPx', () {
      setUp(() {
        setRootFontSize('20px');
      });

      tearDown(() {
        unsetRootFontSize();
      });

      test('converts a rem CSS value to px', () {
        expect(toPx('0.75rem'), '15px');
      });

      test('converts an int value (treated as rem) to px', () {
        expect(toPx(3), '60px');
      });

      test('converts a double (treated as rem) to px', () {
        expect(toPx(1.01), '20.2px');
      });

      test('throws when passed an invalid value', () {
        expect(() => toPx(new Object()), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a num or a String rem value'))))
        );
      });

      test('throws when passed a malformed CSS value string', () {
        expect(() => toPx(''), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a num or a String rem value'))))
        );
      });

      test('throws when passed a CSS value string with a unit other than px', () {
        expect(() => toPx('1em'), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a num or a String rem value'))))
        );
      });
    });
  });
}
