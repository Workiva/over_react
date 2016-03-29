// Currently dart_dev only runs tests on dart files that end with _test.
// So this file's name had to change to match.
// It can be changed back when that issue is taken care of.
// https://github.com/Workiva/dart_dev/issues/74
@TestOn('content-shell || dartium')
library test_util_test;

import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/component_base.dart' as component_base;

import 'test_util_tests/custom_matchers_test.dart' as custom_matchers_test;
import 'test_util_tests/dom_util_test.dart' as test_util_dom_util_test;
import 'test_util_tests/react_util_test.dart' as react_util_test;

main() {
  setClientConfiguration();

  component_base.UiProps.testMode = true;

  custom_matchers_test.main();
  test_util_dom_util_test.main();
  react_util_test.main();
}
