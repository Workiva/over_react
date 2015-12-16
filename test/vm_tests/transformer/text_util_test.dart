@TestOn('vm')
library text_util_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/src/transformer/text_util.dart';

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

    group('stringLiteral()', () {
      test('optionally quotes strings', () {
        expect(stringLiteral('unquoted', quote: false), "unquoted");
        expect(stringLiteral('unquoted', useSingleQuote: true, quote: false), 'unquoted');
        expect(stringLiteral('quoted'), "'quoted'");
        expect(stringLiteral('quoted', useSingleQuote: false), '"quoted"');
      });

      test('escapes quotes', () {
        expect(stringLiteral(r"'", quote: false), r"\'");
        expect(stringLiteral(r'"', useSingleQuote: false, quote: false), r'\"');
      });

      test('does not escape the other kind of quotes', () {
        expect(stringLiteral(r"'", useSingleQuote: false, quote: false), r"'");
        expect(stringLiteral(r'"', quote: false), r'"');
      });

      test('escapes backslashes', () {
        expect(stringLiteral(r'\', quote: false), r'\\');
      });

      test('escapes dollar signs', () {
        expect(stringLiteral(r'$', quote: false), r'\$');
      });

      test('escapes special characters', () {
        // Adapted from dart.convert library's JSON encoder:
        // https://github.com/dart-lang/sdk/blob/1.12.0/tests/lib/convert/json_util_test.dart#L138
        //
        //
        // Copyright 2012, the Dart project authors. All rights reserved.
        // Redistribution and use in source and binary forms, with or without
        // modification, are permitted provided that the following conditions are
        // met:
        //     * Redistributions of source code must retain the above copyright
        //       notice, this list of conditions and the following disclaimer.
        //     * Redistributions in binary form must reproduce the above
        //       copyright notice, this list of conditions and the following
        //       disclaimer in the documentation and/or other materials provided
        //       with the distribution.
        //     * Neither the name of Google Inc. nor the names of its
        //       contributors may be used to endorse or promote products derived
        //       from this software without specific prior written permission.
        // THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
        // "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
        // LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
        // A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
        // OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
        // SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
        // LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
        // DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
        // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
        // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
        expect(stringLiteral('\u0000', quote: false), '\\u0000');
        expect(stringLiteral('\u0001', quote: false), '\\u0001');
        expect(stringLiteral('\u0002', quote: false), '\\u0002');
        expect(stringLiteral('\u0003', quote: false), '\\u0003');
        expect(stringLiteral('\u0004', quote: false), '\\u0004');
        expect(stringLiteral('\u0005', quote: false), '\\u0005');
        expect(stringLiteral('\u0006', quote: false), '\\u0006');
        expect(stringLiteral('\u0007', quote: false), '\\u0007');
        expect(stringLiteral('\u0008', quote: false), '\\b');
        expect(stringLiteral('\u0009', quote: false), '\\t');
        expect(stringLiteral('\u000a', quote: false), '\\n');
        expect(stringLiteral('\u000b', quote: false), '\\u000b');
        expect(stringLiteral('\u000c', quote: false), '\\f');
        expect(stringLiteral('\u000d', quote: false), '\\r');
        expect(stringLiteral('\u000e', quote: false), '\\u000e');
        expect(stringLiteral('\u000f', quote: false), '\\u000f');
        expect(stringLiteral('\u0010', quote: false), '\\u0010');
        expect(stringLiteral('\u0011', quote: false), '\\u0011');
        expect(stringLiteral('\u0012', quote: false), '\\u0012');
        expect(stringLiteral('\u0013', quote: false), '\\u0013');
        expect(stringLiteral('\u0014', quote: false), '\\u0014');
        expect(stringLiteral('\u0015', quote: false), '\\u0015');
        expect(stringLiteral('\u0016', quote: false), '\\u0016');
        expect(stringLiteral('\u0017', quote: false), '\\u0017');
        expect(stringLiteral('\u0018', quote: false), '\\u0018');
        expect(stringLiteral('\u0019', quote: false), '\\u0019');
        expect(stringLiteral('\u001a', quote: false), '\\u001a');
        expect(stringLiteral('\u001b', quote: false), '\\u001b');
        expect(stringLiteral('\u001c', quote: false), '\\u001c');
        expect(stringLiteral('\u001d', quote: false), '\\u001d');
        expect(stringLiteral('\u001e', quote: false), '\\u001e');
        expect(stringLiteral('\u001f', quote: false), '\\u001f');
        expect(stringLiteral('Got \b, \f, \n, \r, \t, \u0000, \\, and ".', quote: false), 'Got \\b, \\f, \\n, \\r, \\t, \\u0000, \\\\, and ".');
        expect(stringLiteral('Got \b\f\n\r\t\u0000\\".', quote: false), 'Got \\b\\f\\n\\r\\t\\u0000\\\\".');
      });

      test('writes the null literal for an input of null', () {
        expect(stringLiteral(null, quote: false), 'null');
        expect(stringLiteral(null), 'null');
      });
    });
  });
}
