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

@TestOn('vm')
library text_util_test;

import 'package:over_react/src/transformer/util.dart';
import 'package:test/test.dart';

main() {
  group('text_util', () {
    group('commentBanner() returns a comment banner', () {
      test('for text', () {
        expect(commentBanner('banner text'),
            '\n'
            '// -----------------------------------------------------------------------------\n'
            '// -----------------------------------------------------------------------------\n'
            '//\n'
            '//   banner text\n'
            '//\n'
            '// -----------------------------------------------------------------------------\n'
            '// -----------------------------------------------------------------------------\n'
            '\n'
        );
      });

      test('for multiline text', () {
        expect(commentBanner('multiline\nbanner text'),
            '\n'
            '// -----------------------------------------------------------------------------\n'
            '// -----------------------------------------------------------------------------\n'
            '//\n'
            '//   multiline\n'
            '//   banner text\n'
            '//\n'
            '// -----------------------------------------------------------------------------\n'
            '// -----------------------------------------------------------------------------\n'
            '\n'
        );
      });

      test('with no top border', () {
        expect(commentBanner('banner text', topBorder: false),
            '\n'
            '//\n'
            '//   banner text\n'
            '//\n'
            '// -----------------------------------------------------------------------------\n'
            '// -----------------------------------------------------------------------------\n'
            '\n'
        );
      });

      test('with no bottom border', () {
        expect(commentBanner('banner text', bottomBorder: false),
            '\n'
            '// -----------------------------------------------------------------------------\n'
            '// -----------------------------------------------------------------------------\n'
            '//\n'
            '//   banner text\n'
            '//\n'
            '\n'
        );
      });

      test('with no borders', () {
        expect(commentBanner('banner text', topBorder: false, bottomBorder: false),
            '\n'
            '//\n'
            '//   banner text\n'
            '//\n'
            '\n'
        );
      });
    });
  });
}
