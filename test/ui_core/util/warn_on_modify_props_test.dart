library warn_on_modify_props_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../shared/map_proxy_tests.dart';

main() {
  group('WarnOnModifyProps:', () {
    group('- Map proxy tests', () {
      mapProxyTests((Map backingMap) => new WarnOnModifyProps(backingMap));
    });

    group('[]= operator', () {
      test('issues a warning on usage', () {

      });
    });

    group('addAll', () {
      test('issues a warning on usage', () {

      });
    });

    group('clear', () {
      test('issues a warning on usage', () {

      });
    });

    group('putIfAbsent', () {
      test('issues a warning on usage', () {

      });
    });

    group('remove', () {
      test('issues a warning on usage', () {

      });
    });
  });
}
