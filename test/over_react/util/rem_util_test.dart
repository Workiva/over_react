// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library rem_util_test;

import 'dart:async';
import 'dart:html';

import 'package:over_react/src/util/css_value_util.dart';
import 'package:over_react/src/util/rem_util.dart';
import 'package:over_react/src/util/test_mode.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';

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

      test('converts a px CSS value String to rem', () {
        expect(toRem('15px'), new CssValue(0.75, 'rem'));
      });

      test('converts a px CssValue instance to rem', () {
        expect(toRem(new CssValue.parse('15px')), new CssValue(0.75, 'rem'));
      });

      test('converts nums (treated as px) to rem', () {
        expect(toRem(15), new CssValue(0.75, 'rem'));
        expect(toRem(20.2), new CssValue(1.01, 'rem'));
      });

      test('does not convert nums when `treatNumAsRem` is true', () {
        expect(toRem(15, treatNumAsRem: true), new CssValue(15, 'rem'));
        expect(toRem(20.2, treatNumAsRem: true), new CssValue(20.2, 'rem'));
      });

      test('gracefully handles a rem String, not doing any conversion', () {
        expect(toRem('1334rem'), new CssValue(1334, 'rem'));
      });

      test('gracefully handles a rem CssValue, not doing any conversion', () {
        expect(toRem(new CssValue(1334, 'rem')), new CssValue(1334, 'rem'));
      });

      test('gracefully passes through `null`', () {
        expect(toRem(null), null);
      });

      test('throws when passed an invalid value', () {
        expect(() => toRem(new Object()), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a px num or a String px/rem value'))))
        );
      });

      test('throws when passed a malformed CSS value string', () {
        expect(() => toRem(''), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a px num or a String px/rem value'))))
        );
      });

      group('throws when passed a CSS value string with a unit other than px/rem', () {
        test('', () {
          expect(() => toRem('1em'), allOf(
              throwsArgumentError,
              throwsA(hasToStringValue(contains('must be a px num or a String px/rem value'))))
          );
        });

        test('unless `passThroughUnsupportedUnits` is true', () {
          expect(toRem('1em', passThroughUnsupportedUnits: true), new CssValue.parse('1em'));
        });
      });

      group('throws when passed a CssValue instance with a unit other than px/rem', () {
        test('', () {
          expect(() => toRem(new CssValue.parse('1em')), allOf(
              throwsArgumentError,
              throwsA(hasToStringValue(contains('must be a px num or a String px/rem value'))))
          );
        });

        test('unless `passThroughUnsupportedUnits` is true', () {
          expect(toRem(new CssValue.parse('1em'), passThroughUnsupportedUnits: true), new CssValue.parse('1em'));
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

      test('converts nums (treated as rem) to px', () {
        expect(toPx(3), new CssValue(60, 'px'));
        expect(toPx(1.01), new CssValue(20.2, 'px'));
      });

      test('does not convert nums when `treatNumAsPx` is true', () {
        expect(toPx(3, treatNumAsPx: true), new CssValue(3, 'px'));
        expect(toPx(1.01, treatNumAsPx: true), new CssValue(1.01, 'px'));
      });

      test('gracefully handles a px String, not doing any conversion', () {
        expect(toPx('1334px'), new CssValue(1334, 'px'));
      });

      test('gracefully handles a px CssValue, not doing any conversion', () {
        expect(toPx(new CssValue(1334, 'px')), new CssValue(1334, 'px'));
      });

      test('gracefully passes through `null`', () {
        expect(toPx(null), null);
      });

      test('throws when passed an invalid value', () {
        expect(() => toPx(new Object()), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a rem num or a String px/rem value'))))
        );
      });

      test('throws when passed a malformed CSS value string', () {
        expect(() => toPx(''), allOf(
            throwsArgumentError,
            throwsA(hasToStringValue(contains('must be a rem num or a String px/rem value'))))
        );
      });

      group('throws when passed a CSS value string with a unit other than px/rem', () {
        test('', () {
          expect(() => toPx('1em'), allOf(
              throwsArgumentError,
              throwsA(hasToStringValue(contains('must be a rem num or a String px/rem value'))))
          );
        });

        test('unless `passThroughUnsupportedUnits` is true', () {
          expect(toPx('1em', passThroughUnsupportedUnits: true), new CssValue.parse('1em'));
        });
      });

      group('throws when passed a CssValue instance with a unit other than px/rem', () {
        test('', () {
          expect(() => toPx(new CssValue.parse('1em')), allOf(
              throwsArgumentError,
              throwsA(hasToStringValue(contains('must be a rem num or a String px/rem value'))))
          );
        });

        test('unless `passThroughUnsupportedUnits` is true', () {
          expect(toPx(new CssValue.parse('1em'), passThroughUnsupportedUnits: true), new CssValue.parse('1em'));
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

        var calls = <double>[];
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
        List<double> calls = [];

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
        List<double> calls = [];
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

    group('automatically mounts a "rem change sensor" when `toRem` is called for the first time', () {
      setUp(() {
        destroyRemChangeSensor();
        // Disabling test mode to ensure that the rem change sensor is created.
        // See workaround comment in `toRem`.
        disableTestMode();
      });

      tearDown(() {
        destroyRemChangeSensor();
        // Re-enable test mode
        enableTestMode();
      });

      group('in Google Chrome', () {
        setUp(() {
          expect(querySelector('#rem_change_sensor'), isNull,
              reason: '#rem_change_sensor element should not get mounted until `toRem` is first called.');
          expect(document.documentElement.getComputedStyle().fontSize, isNot('20px'),
              reason: 'The tests in this group will not work if the root font size is already 20px.');

          toRem('1rem');
        });

        test('', () {
          expect(querySelector('#rem_change_sensor'), isNotNull, reason: 'test setup sanity check');
        });

        test('that results in `toRem` returning the expected value when the root document font size changes', () async {
          setRootFontSize('20px');
          await new Future.delayed(const Duration(milliseconds: 100));
          expect(toRem('20px').number, 1);
        });
      }, testOn: 'dartium || chrome');

      test('only in Google Chrome', () async {
        toRem('1rem');
        await new Future.delayed(const Duration(milliseconds: 100));
        expect(querySelector('#rem_change_sensor'), isNull, reason: 'test setup sanity check');
      }, testOn: '!chrome && !dartium');
    }, testOn: 'browser');
  });
}
