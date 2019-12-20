import 'dart:js';

import 'package:test/test.dart';

bool muiJsIsAvailable() {
  // Skip these tests if the JS file isn't loaded (e.g. if you're running tests without an internet connection, etc)
  if (context['MaterialUI'] == null) {
    test('MaterialUI', () {},
        skip: 'Skipping MaterialUI tests because the required JS file from unpkg.com did not load');
    return false;
  }
  return true;
}
