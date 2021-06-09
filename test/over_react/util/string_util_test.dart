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
library string_util_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Main entry point for StringUtil testing
main() {
  group('unindent', () {
    test('unindents a multiline string correctly', () {
      String testStr =
          '''
          Yo
            How u doin'?
          ''';

      String expectedResult =
'''
Yo
  How u doin'?''';

      expect(unindent(testStr), expectedResult);
    });
  });
}
