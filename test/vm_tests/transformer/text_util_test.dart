@TestOn('vm')
library text_util_test;

import 'package:over_react/src/transformer/text_util.dart';
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
