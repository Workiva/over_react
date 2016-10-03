library rem_util_test;

import 'dart:html';

import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/util/css_value_util.dart';
import 'package:web_skin_dart/src/ui_core/util/rem_util.dart';
import 'package:web_skin_dart/test_util.dart';

import '../../wsd_test_util/validation_util_helpers.dart';

/// Main entry point for rem_util testing
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

      test('returns null when `pxValue` is null', () {
        expect(toRem(null), isNull);
      });

      test('returns `pxValue` unaltered when it is not a supported type', () {

      });

      test('converts a px CSS value String to rem', () {
        expect(toRem('15px'), new CssValue(0.75, 'rem'));
      });

      test('converts a px CssValue instance to rem', () {
        expect(toRem(new CssValue.parse('15px')), new CssValue(0.75, 'rem'));
      });

      test('converts an int value (treated as px) to rem', () {
        expect(toRem(15), new CssValue(0.75, 'rem'));
      });

      test('converts a double (treated as px) to rem', () {
        expect(toRem(20.2), new CssValue(1.01, 'rem'));
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

      group('warns (and returns corresponding CssValue) when passed', () {
        setUp(() {
          startRecordingValidationWarnings();
        });

        tearDown(() {
          stopRecordingValidationWarnings();
        });

        test('a CSS value string with a unit other than px', () {
          var value = toRem('1em');

          verifyValidationWarning('`1em` is not a num or a String px value. Value cannot be converted to `rem` units.');
          expect(value, new CssValue.parse('1em'));
        });

        test('a CssValue instance with a unit other than px', () {
          var value = toRem(new CssValue.parse('1em'));

          verifyValidationWarning('`1em` is not a num or a String px value. Value cannot be converted to `rem` units.');
          expect(value, new CssValue.parse('1em'));
        });
      });
    });

    group('toPx', () {
      setUp(() {
        setRootFontSize('20px');
      });

      tearDown(() {
        unsetRootFontSize();
      });

      test('converts a rem CSS value String to px', () {
        expect(toPx('0.75rem'), new CssValue(15, 'px'));
      });

      test('converts a rem CssValue instance to px', () {
        expect(toPx(new CssValue.parse('0.75rem')), new CssValue(15, 'px'));
      });

      test('converts an int value (treated as rem) to px', () {
        expect(toPx(3), new CssValue(60, 'px'));
      });

      test('converts a double (treated as rem) to px', () {
        expect(toPx(1.01), new CssValue(20.2, 'px'));
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

      group('warns (and returns corresponding CssValue) when passed', () {
        setUp(() {
          startRecordingValidationWarnings();
        });

        tearDown(() {
          stopRecordingValidationWarnings();
        });

        test('a CSS value string with a unit other than px', () {
          var value = toPx('1em');

          verifyValidationWarning('`1em` is not a num or a String rem value. Value cannot be converted to `px` units.');
          expect(value, new CssValue.parse('1em'));
        });

        test('a CssValue instance with a unit other than px', () {
          var value = toPx(new CssValue.parse('1em'));

          verifyValidationWarning('`1em` is not a num or a String rem value. Value cannot be converted to `px` units.');
          expect(value, new CssValue.parse('1em'));
        });
      });
    });

    group('onRemChange', () {
      tearDown(() async {
        var nextChange = onRemChange.first;
        unsetRootFontSize();
        await nextChange;
      });

      test('initializes the sensor when the first listener is added and '
          'correctly dispatches an event in resopnse to the first change', () async {
        expect(querySelector('#rem_change_sensor'), isNull);

        var calls = [];
        var listener = onRemChange.listen(calls.add);

        expect(querySelector('#rem_change_sensor'), isNotNull);
        expect(calls, isEmpty);

        var nextChange = onRemChange.first;
        setRootFontSize('17px');

        await nextChange;

        expect(calls, [17]);

        listener.cancel();
      });

      test('does not dispatch duplicate events when there are multiple listeners', () async {
        var calls = [];

        var listener1 = onRemChange.listen((_) {});
        var listener2 = onRemChange.listen(calls.add);

        var nextChange = onRemChange.first;
        setRootFontSize('17px');

        await nextChange;

        expect(calls, hasLength(1));

        listener1.cancel();
        listener2.cancel();
      });

      test('does not dispatch events when recomputeRootFontSize is called and there is no change', () async {
        var calls = [];
        var listener = onRemChange.listen(calls.add);

        recomputeRootFontSize();

        var nextChange = onRemChange.first;
        setRootFontSize('17px');

        await nextChange;

        expect(calls, [17]);

        listener.cancel();
      });
    });

    test('rootFontSize returns the latest root font size computed', () async {
      setRootFontSize('15px');
      await onRemChange.first;

      expect(rootFontSize, 15);

      setRootFontSize('16px');
      await onRemChange.first;

      expect(rootFontSize, 16);
    });
  });
}
