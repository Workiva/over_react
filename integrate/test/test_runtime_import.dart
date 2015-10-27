@TestOn('content-shell || dartium')
library test;

import 'package:react/react_client.dart' show setClientConfiguration;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:test/test.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Entry point into tests
main() {
  setClientConfiguration();

  test('renders without breaking', () {
    var well = react_test_utils.renderIntoDocument(Well()('Hello World!'));
    expect(well, isNotNull);
  });
}
