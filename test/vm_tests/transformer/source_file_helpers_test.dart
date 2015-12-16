@TestOn('vm')
library source_file_helpers_test;

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/src/transformer/source_file_helpers.dart';

main() {
  group('source_file_helpers', () {
    group('TransformedSourceFile', () {
      SourceFile testSourceFile;
      TransformedSourceFile transformedFile;

      setUp(() {
        testSourceFile = new SourceFile('0123456789', url: 'test_source_file.dart');
        transformedFile = new TransformedSourceFile(testSourceFile);
      });

      group('replace()', () {
        test('replaces a span of text and outputs the result', () {
          transformedFile.replace(testSourceFile.span(3, 8), '{replaced}');
          expect(transformedFile.getTransformedText(), '012{replaced}89');
        });

        test('replaces multiple spans of text and outputs the result', () {
          transformedFile.replace(testSourceFile.span(1, 2), '{replaced 1}');
          transformedFile.replace(testSourceFile.span(6, 9), '{replaced 2}');
          transformedFile.replace(testSourceFile.span(4, 6), '{replaced 3}');
          expect(transformedFile.getTransformedText(), '0{replaced 1}23{replaced 3}{replaced 2}9');
        });

        test('inserts text and outputs the result', () {
          transformedFile.insert(testSourceFile.location(4), '{inserted}');
          expect(transformedFile.getTransformedText(), '0123{inserted}456789');
        });
      });

      group('insert()', () {
        test('inserts multiple pieces of text and outputs the result', () {
          transformedFile.insert(testSourceFile.location(1), '{inserted 1}');
          transformedFile.insert(testSourceFile.location(6), '{inserted 2}');
          transformedFile.insert(testSourceFile.location(4), '{inserted 3}');
          expect(transformedFile.getTransformedText(), '0{inserted 1}123{inserted 3}45{inserted 2}6789');
        });

        test('throws if sections of replaced text overlap each other', () {
          transformedFile.replace(testSourceFile.span(1, 3), '{replaced 1}');
          transformedFile.replace(testSourceFile.span(0, 2), '{replaced 2}');
          expect(() => transformedFile.getTransformedText(), throwsA(startsWith('Overlapping replacement')));
        });
      });

      group('remove()', () {
        const String text = 'line 0\nline 1\nline 2\nline 3\nline 4';
        SourceSpan lines1Through3Span;

        setUp(() {
          testSourceFile = new SourceFile(text);
          transformedFile = new TransformedSourceFile(testSourceFile);

          var lines1Through3 = '\nline 1\nline 2\nline 3'.allMatches(text).single;
          lines1Through3Span = testSourceFile.span(lines1Through3.start, lines1Through3.end);
        });

        test('removes spans of text, removing newlines by default', () {
          transformedFile.remove(lines1Through3Span);
          expect(transformedFile.getTransformedText(), 'line 0\nline 4');
        });

        test('removes spans of text, preserving newlines when specified', () {
          transformedFile.remove(lines1Through3Span, preserveNewlines: true);
          expect(transformedFile.getTransformedText(), 'line 0\n\n\n\nline 4');
        });
      });

      group('`isModified`', () {
        test('is true when a replacement has been made', () {
          transformedFile.replace(testSourceFile.span(3, 8), '{replaced}');
          expect(transformedFile.isModified, isTrue);
        });

        test('is true when an insertion has been made', () {
          transformedFile.insert(testSourceFile.location(3), '{replaced}');
          expect(transformedFile.isModified, isTrue);
        });

        test('is false for a pristine TransformedSourceFile', () {
          expect(transformedFile.isModified, isFalse);
        });
      });

      group('iterateReplacements()', () {
        test('iterates through the replacements using the specified callbacks', () {
          var unmodifieds = [];
          var additions = [];
          var removals = [];

          var all = [];

          transformedFile.remove(testSourceFile.span(2, 3));
          transformedFile.remove(testSourceFile.span(8, 9));
          transformedFile.insert(testSourceFile.location(1), '{inserted 1}');
          transformedFile.insert(testSourceFile.location(7), '{inserted 2}');
          transformedFile.replace(testSourceFile.span(5, 7), '{replaced 1}');
          transformedFile.replace(testSourceFile.span(0, 1), '{replaced 2}');

          transformedFile.iterateReplacements(
              onUnmodified: (text) {
                unmodifieds.add(text);
                all.add(text);
              },
              onRemoval: (text) {
                removals.add(text);
                all.add(text);
              },
              onAddition: (text) {
                additions.add(text);
                all.add(text);
              }
          );

          expect(unmodifieds, equals(['1', '34', '7', '9']));
          expect(additions, equals(['{replaced 2}', '{inserted 1}', '{replaced 1}', '{inserted 2}']));
          expect(removals, equals(['0', '2', '56', '8']));

          expect(all, equals([
            '0',            // -  removal
            '{replaced 2}', // +  addition
            '{inserted 1}', // +  addition
            '1',            //    unmodified
            '2',            // -  removal
            '34',           //    unmodified
            '56',           // -  removal
            '{replaced 1}', // +  addition
            '{inserted 2}', // +  addition
            '7',            //    unmodified
            '8',            // -  removal
            '9'             //    unmodified
          ]), reason: 'should have called all parts in the right order');
        });
      });

      group('getHtmlDiff()', () {
        test('returns an HTML page containing the diff of the modified file', () {
          transformedFile.remove(testSourceFile.span(2, 3));
          transformedFile.remove(testSourceFile.span(8, 9));
          transformedFile.insert(testSourceFile.location(1), '{inserted 1}');
          transformedFile.insert(testSourceFile.location(7), '{inserted 2}');
          transformedFile.replace(testSourceFile.span(5, 7), '{replaced 1}');
          transformedFile.replace(testSourceFile.span(0, 1), '{replaced 2}');

          var html = transformedFile.getHtmlDiff();

          expect(html, matches(new RegExp(r'^\s*<\!DOCTYPE html>\s*<html>')));
          expect(html, contains('<title>web_skin_dart Transformer Diff - ' 'test_source_file.dart' '</title>'));
          expect(html, contains(
              '<pre>'
                '<span class="diff-removal">'     '0'             '</span>'
                '<span class="diff-addition">'    '{replaced 2}'  '</span>'
                '<span class="diff-addition">'    '{inserted 1}'  '</span>'
                '<span class="diff-unmodified">'  '1'             '</span>'
                '<span class="diff-removal">'     '2'             '</span>'
                '<span class="diff-unmodified">'  '34'            '</span>'
                '<span class="diff-removal">'     '56'            '</span>'
                '<span class="diff-addition">'    '{replaced 1}'  '</span>'
                '<span class="diff-addition">'    '{inserted 2}'  '</span>'
                '<span class="diff-unmodified">'  '7'             '</span>'
                '<span class="diff-removal">'     '8'             '</span>'
                '<span class="diff-unmodified">'  '9'             '</span>'
              '</pre>'
          ));
          expect(html, matches(new RegExp(r'</html>\s*$')));
        });
      });
    });

    group('getSpan()', () {
      const String source =
          '\n'
          '/// Doc comment\n'
          '@Annotation\n'
          'class Node {}\n';

      SourceFile sourceFile;
      AnnotatedNode node;

      setUp(() {
        sourceFile = new SourceFile(source);
        node = parseCompilationUnit(source).declarations.single;
      });

      test('returns a SourceSpan for a node, skipping its doc comments and meta by default', () {
        var span = getSpan(sourceFile, node);
        expect(span.start.offset, equals(source.indexOf('class')));
        expect(span.end.offset, equals(source.indexOf('}') + 1));
      });

      test('returns a SourceSpan for a node, including its doc comments and meta', () {
        var span = getSpan(sourceFile, node, skipCommentAndMetadata: false);
        expect(span.start.offset, equals(source.indexOf('///')));
        expect(span.end.offset, equals(source.indexOf('}') + 1));
      });
    });
  });
}
