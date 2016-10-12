// Currently dart_dev only runs tests on dart files that end with _test.
// So this file's name had to change to match.
// It can be changed back when that issue is taken care of.
// https://github.com/Workiva/dart_dev/issues/74
@TestOn('browser')
library test_util_test;

import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:over_react/over_react.dart';

import 'test_util_tests/custom_matchers_test.dart' as custom_matchers_test;
import 'test_util_tests/dom_util_test.dart' as test_util_dom_util_test;
import 'test_util_tests/react_util_test.dart' as react_util_test;

main() {
  setClientConfiguration();

  enableTestMode();

  custom_matchers_test.main();
  test_util_dom_util_test.main();
  react_util_test.main();
}
