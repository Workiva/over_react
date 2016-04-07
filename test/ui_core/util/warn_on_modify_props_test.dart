library warn_on_modify_props_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../shared/map_proxy_tests.dart';
import '../../wsd_test_util/validation_util_helpers.dart';

main() {
  group('WarnOnModifyProps:', () {
    group('- Map proxy tests', () {
      mapProxyTests((Map backingMap) => new WarnOnModifyProps(backingMap));
    });

    group('warns on', () {
      WarnOnModifyProps warningPropsMap;

      setUp(() {
        warningPropsMap = new WarnOnModifyProps({
          'title': 'Warn about them props!!!'
        });

        startRecordingValidationWarnings();
      });

      tearDown(() {
        stopRecordingValidationWarnings();
      });

      assertValidationWarnings() {
        verifyValidationWarning(contains(unindent(
          '''
          The props being modified belong to an existing component. Modifications to these props may cause
          undesired behavior.
          '''
        )));
      }

      group('[]= operator', () {
        setUp(() {
          warningPropsMap['key'] = 'value';
        });

        test('usage', () {
          assertValidationWarnings();
        });
      });

      group('addAll', () {
        setUp(() {
          warningPropsMap.addAll({
            'key': 'value',
            'otherKey': 'otherValue'
          });
        });

        test('usage', () {
          assertValidationWarnings();
        });
      });

      group('clear', () {
        setUp(() {
          warningPropsMap.clear();
        });

        test('usage', () {
          assertValidationWarnings();
        });
      });

      group('putIfAbsent', () {
        setUp(() {
          warningPropsMap.putIfAbsent('key', () => 'value');
        });

        test('usage', () {
          assertValidationWarnings();
        });
      });

      group('remove', () {
        setUp(() {
          warningPropsMap.remove('title');
        });

        test('usage', () {
          assertValidationWarnings();
        });
      });
    });
  });
}
