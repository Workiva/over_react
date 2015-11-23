import 'package:web_skin_dart/src/transformer/text_util.dart';
import 'package:test/test.dart';

main() {
  group('text_util', () {
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

      group('escapes whitespace:', () {
        test('BACKSPACE', () {
          expect(stringLiteral('\b', quote: false), r'\b');
        });

        test('TAB', () {
          expect(stringLiteral('\t', quote: false), r'\t');
        });

        test('NEWLINE', () {
          expect(stringLiteral('\n', quote: false), r'\n');
        });

        test('FORM_FEED', () {
          expect(stringLiteral('\f', quote: false), r'\f');

        });

        test('CARRIAGE_RETURN', () {
          expect(stringLiteral('\r', quote: false), r'\r');
        });
      });

      test('escapes special characters', () {
        expect(stringLiteral('\u0000', quote: false), r'\u0000');
        expect(stringLiteral('\u001e', quote: false), r'\u001e');
      });

      test('passes through other characters', () {
        expect(stringLiteral('alphanumeric123', quote: false), 'alphanumeric123');
        expect(stringLiteral('\u007f', quote: false), '\u007f');
        expect(stringLiteral('★', quote: false), '★');
      });

      test('writes the null literal', () {
        expect(stringLiteral(null, quote: false), 'null');
        expect(stringLiteral(null), 'null');
      });
    });
  });
}
