// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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

@TestOn('browser')
library rem_util_test;

import 'dart:async';
import 'dart:html';

import 'package:over_react/src/util/css_value_util.dart';
import 'package:over_react/src/util/rem_util.dart';
import 'package:over_react/src/util/test_mode.dart';
import 'package:pedantic/pedantic.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';

/// Main entry point for rem_util testing
main() {
  group('rem_util', () {
    // Ensure this suite cleans up any sensor nodes it adds to the body,
    // and doesn't pollute other tests.
    tearDownAll(() async {
      await destroyRemChangeSensor();
    });

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

      tearDown(unsetRootFontSize);

      test('converts a px CSS value String to rem', () {
        expect(toRem('15px'), CssValue(0.75, 'rem'));
      });

      test('converts a px CssValue instance to rem', () {
        expect(toRem(CssValue.parse('15px')), CssValue(0.75, 'rem'));
      });

      test('converts nums (treated as px) to rem', () {
        expect(toRem(15), CssValue(0.75, 'rem'));
        expect(toRem(20.2), CssValue(1.01, 'rem'));
      });

      test('does not convert nums when `treatNumAsRem` is true', () {
        expect(toRem(15, treatNumAsRem: true), CssValue(15, 'rem'));
        expect(toRem(20.2, treatNumAsRem: true), CssValue(20.2, 'rem'));
      });

      test('gracefully handles a rem String, not doing any conversion', () {
        expect(toRem('1334rem'), CssValue(1334, 'rem'));
      });

      test('gracefully handles a rem CssValue, not doing any conversion', () {
        expect(toRem(CssValue(1334, 'rem')), CssValue(1334, 'rem'));
      });

      test('gracefully passes through `null`', () {
        expect(toRem(null), null);
      });

      test('throws when passed an invalid value', () {
        expect(() => toRem(Object()), allOf(
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
          expect(toRem('1em', passThroughUnsupportedUnits: true), CssValue.parse('1em'));
        });
      });

      group('throws when passed a CssValue instance with a unit other than px/rem', () {
        test('', () {
          expect(() => toRem(CssValue.parse('1em')), allOf(
              throwsArgumentError,
              throwsA(hasToStringValue(contains('must be a px num or a String px/rem value'))))
          );
        });

        test('unless `passThroughUnsupportedUnits` is true', () {
          expect(toRem(CssValue.parse('1em'), passThroughUnsupportedUnits: true), CssValue.parse('1em'));
        });
      });
    });

    group('toPx', () {
      setUp(() {
        setRootFontSize('20px');
      });

      tearDown(unsetRootFontSize);

      test('converts a rem CSS value String to px', () {
        expect(toPx('0.75rem'), CssValue(15, 'px'));
      });

      test('converts a rem CssValue instance to px', () {
        expect(toPx(CssValue.parse('0.75rem')), CssValue(15, 'px'));
      });

      test('converts nums (treated as rem) to px', () {
        expect(toPx(3), CssValue(60, 'px'));
        expect(toPx(1.01), CssValue(20.2, 'px'));
      });

      test('does not convert nums when `treatNumAsPx` is true', () {
        expect(toPx(3, treatNumAsPx: true), CssValue(3, 'px'));
        expect(toPx(1.01, treatNumAsPx: true), CssValue(1.01, 'px'));
      });

      test('gracefully handles a px String, not doing any conversion', () {
        expect(toPx('1334px'), CssValue(1334, 'px'));
      });

      test('gracefully handles a px CssValue, not doing any conversion', () {
        expect(toPx(CssValue(1334, 'px')), CssValue(1334, 'px'));
      });

      test('gracefully passes through `null`', () {
        expect(toPx(null), null);
      });

      test('throws when passed an invalid value', () {
        expect(() => toPx(Object()), allOf(
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
          expect(toPx('1em', passThroughUnsupportedUnits: true), CssValue.parse('1em'));
        });
      });

      group('throws when passed a CssValue instance with a unit other than px/rem', () {
        test('', () {
          expect(() => toPx(CssValue.parse('1em')), allOf(
              throwsArgumentError,
              throwsA(hasToStringValue(contains('must be a rem num or a String px/rem value'))))
          );
        });

        test('unless `passThroughUnsupportedUnits` is true', () {
          expect(toPx(CssValue.parse('1em'), passThroughUnsupportedUnits: true), CssValue.parse('1em'));
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

        // Wait for the async mounting of the rem change sensor node.
        await Future(() {});

        expect(querySelector('#rem_change_sensor'), isNotNull);
        expect(calls, isEmpty);

        var nextChange = onRemChange.first;
        setRootFontSize('17px');

        await nextChange;

        expect(calls, [17]);

        await listener.cancel();
      });

      group('', () {
        setUpAll(() async {
          // These tests depend on the sensor being initialized before the test starts.
          await initRemChangeSensor();
        });

        test('does not dispatch duplicate events when there are multiple listeners', () async {
          List<double> calls = [];

          var listener1 = onRemChange.listen((_) {});
          var listener2 = onRemChange.listen(calls.add);

          // Wait for the async mounting of the rem change sensor node.
          await Future(() {});

          var nextChange = onRemChange.first;
          setRootFontSize('17px');

          await nextChange;

          expect(calls, hasLength(1));

          await listener1.cancel();
          await listener2.cancel();
        });

        test('does not dispatch events when recomputeRootFontSize is called and there is no change', () async {
          List<double> calls = [];
          var listener = onRemChange.listen(calls.add);

          // Wait for the async mounting of the rem change sensor node.
          await Future(() {});

          recomputeRootFontSize();

          var nextChange = onRemChange.first;
          setRootFontSize('17px');

          await nextChange;

          expect(calls, [17]);

          await listener.cancel();
        });
      });
    });

    test('rootFontSize returns the latest root font size computed', () async {
      // This test depends on the sensor being initialized before the test starts.
      await initRemChangeSensor();

      setRootFontSize('15px');
      await onRemChange.first;

      expect(rootFontSize, 15);

      setRootFontSize('16px');
      await onRemChange.first;

      expect(rootFontSize, 16);
    });

    group('destroyRemChangeSensor', () {
      setUpAll(() async {
        await initRemChangeSensor();
        expect(changeSensor, isNotNull, reason: 'test setup sanity check');
        expect(changeSensorMountNode, isNotNull, reason: 'test setup sanity check');
        expect(document.body.children.single, changeSensorMountNode, reason: 'test setup sanity check');

        await destroyRemChangeSensor();
      });

      test('adds the `#rem_change_sensor` element', () {
        expect(changeSensorMountNode, isNull);
        expect(document.body.children, isEmpty);
      });

      test('sets `_changeSensor` to null', () {
        expect(changeSensor, isNull);
      });
    });

    group('initRemChangeSensor', () {
      setUpAll(() async {
        await destroyRemChangeSensor();
        expect(changeSensor, isNull, reason: 'test setup sanity check');
        expect(changeSensorMountNode, isNull, reason: 'test setup sanity check');
        expect(document.body.children, isEmpty, reason: 'test setup sanity check');

        await initRemChangeSensor();
      });

      test('adds the `#rem_change_sensor` element', () {
        expect(changeSensorMountNode, isNotNull);
        expect(document.body.children, [changeSensorMountNode]);
      });

      test('initializes `_changeSensor` ', () {
        expect(changeSensor, isNotNull);
      });
    });

    group('automatically mounts a "rem change sensor" when `toRem` is called for the first time', () {
      setUp(() async {
        await destroyRemChangeSensor();
        // Disabling test mode to ensure that the rem change sensor is created.
        // See workaround comment in `toRem`.
        disableTestMode();
      });

      tearDown(() async {
        await destroyRemChangeSensor();
        // Re-enable test mode
        enableTestMode();
      });

      group('in Google Chrome', () {
        setUp(() async {
          expect(querySelector('#rem_change_sensor'), isNull,
              reason: '#rem_change_sensor element should not get mounted until `toRem` is first called.');
          expect(document.documentElement.getComputedStyle().fontSize, isNot('20px'),
              reason: 'The tests in this group will not work if the root font size is already 20px.');

          toRem('1rem');
          // Wait for the async mounting of the rem change sensor node.
          await Future(() {});
        });

        test('', () {
          expect(querySelector('#rem_change_sensor'), isNotNull, reason: 'test setup sanity check');
        });

        test('that results in `toRem` returning the expected value when the root document font size changes', () async {
          setRootFontSize('20px');
          await Future.delayed(const Duration(milliseconds: 100));
          expect(toRem('20px').number, 1);
        });
      }, testOn: 'chrome');

      test(', except in non-Chrome browsers', () async {
        toRem('1rem');
        await Future.delayed(const Duration(milliseconds: 100));
        expect(querySelector('#rem_change_sensor'), isNull, reason: 'test setup sanity check');
      }, testOn: '!chrome');
    });

    group('interleaved asynchonous intialization/destruction of change sensors works without race conditions:', () {
      setUp(() async {
        // Ensure we start with no sensor.
        await destroyRemChangeSensor();
      });

      tearDown(() async {
        await destroyRemChangeSensor();
      });

      test('multiple unawaited init calls in a row', () async {
        await initRemChangeSensor();
        await initRemChangeSensor();
        await Future(() {});

        expect(querySelectorAll('#rem_change_sensor'), hasLength(1),
            reason: 'inits the sensor properly wihtout creating duplicates');

        await destroyRemChangeSensor();
        expect(querySelector('#rem_change_sensor'), isNull,
            reason: 'can properly destroy the sensor afterwards since it was not left in a bad state');
      });

      test('destroy after unawaited init', () async {
        unawaited(initRemChangeSensor());
        await destroyRemChangeSensor();

        expect(querySelector('#rem_change_sensor'), isNull,
            reason: 'destroys the sensor (or completes it from being inited)');

        await initRemChangeSensor();
        expect(querySelector('#rem_change_sensor'), isNotNull,
            reason: 'can properly init the sensor afterwards since it was not left in a bad state');
      });

      test('init after unawaited destroy', () async {
        unawaited(destroyRemChangeSensor());
        await initRemChangeSensor();
        await Future(() {});

        expect(querySelector('#rem_change_sensor'), isNotNull,
            reason: 'inits the sensor, since destruction should be sync');

        await destroyRemChangeSensor();
        expect(querySelector('#rem_change_sensor'), isNull,
            reason: 'can properly destroy the sensor afterwards since it was not left in a bad state');
      });
    });
  });
}
