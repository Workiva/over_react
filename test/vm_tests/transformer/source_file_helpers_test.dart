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
        testSourceFile = new SourceFile('0123456789');
        transformedFile = new TransformedSourceFile(testSourceFile);
      });

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
