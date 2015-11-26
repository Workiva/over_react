@TestOn('vm')
library impl_generation_test;

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:barback/barback.dart';
import 'package:mockito/mockito.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart';
import 'package:web_skin_dart/src/transformer/impl_generation.dart';
import 'package:web_skin_dart/src/transformer/source_file_helpers.dart';

main() {
  group('ComponentDeclarations', () {
    group('preserves line numbers for', () {
      ImplGenerator implGenerator;

      MockTransformLogger logger;
      SourceFile sourceFile;
      TransformedSourceFile transformedFile;
      CompilationUnit unit;
      ComponentDeclarations declarations;

      void setUpAndParse(String source) {
        logger = new MockTransformLogger();

        sourceFile = new SourceFile(source);
        transformedFile = new TransformedSourceFile(sourceFile);

        unit = parseCompilationUnit(source);
        declarations = new ComponentDeclarations(unit, sourceFile, logger);
        implGenerator = new ImplGenerator(logger, transformedFile);
      }

      void verifyNoErrors() {
        // Check all permutations of optional parameters being specified
        // since they look like different calls to Mockito.
        verifyNever(logger.warning(any));
        verifyNever(logger.warning(any, span: any));
        verifyNever(logger.warning(any, asset: any));
        verifyNever(logger.warning(any, span: any, asset: any));
        verifyNever(logger.error(any));
        verifyNever(logger.error(any, span: any));
        verifyNever(logger.error(any, asset: any));
        verifyNever(logger.error(any, span: any, asset: any));

        expect(declarations.hasErrors, isFalse);
      }

      void preservedLineNumbersTest(String source) {
        var lines = source.split('\n');
        for (int i = 0; i < lines.length; i++) {
          lines[i] = '/* line $i start */${lines[i]}/* line $i end */';
        }
        String numberedSource = lines.join('\n');

        setUpAndParse(numberedSource);
        implGenerator.generateComponent(declarations);

        String transformedSource = transformedFile.getTransformedText();

        var transformedLines = transformedSource.split('\n');
        for (int i = 0; i < lines.length; i++) {
          expect(transformedLines[i], startsWith('/* line $i start */'));
          expect(transformedLines[i], endsWith('/* line $i end */'));
        }
      }

      test('stateful components', () {
        preservedLineNumbersTest('''
          @Factory()
          UiFactory<FooProps> Foo;

          @Props()
          class FooProps {
            var bar;
            var baz;
          }

          @State()
          class FooState {
            var bar;
            var baz;
          }

          @Component()
          class FooComponent {
            render() {
              return null;
            }
          }
        ''');
        verifyNoErrors();
      });

      test('props mixins', () {
        preservedLineNumbersTest('''
          @PropsMixin() class FooPropsMixin {
            Map get props;

            var bar;
            var baz;
          }
        ''');
        verifyNoErrors();
      });

      test('state mixins', () {
        preservedLineNumbersTest('''
          @StateMixin() class FooStateMixin {
            Map get state;

            var bar;
            var baz;
          }
        ''');
        verifyNoErrors();
      });

      test('abstract props classes', () {
        preservedLineNumbersTest('''
          @AbstractProps() class AbstractFooProps {
            var bar;
            var baz;
          }
        ''');
        verifyNoErrors();
      });

      test('abstract state classes', () {
        preservedLineNumbersTest('''
          @AbstractState() class AbstractFooState {
            var bar;
            var baz;
          }
        ''');
        verifyNoErrors();
      });

      test('props mixins with accessors with funky formatting', () {
        preservedLineNumbersTest('''
          @PropsMixin()
          class FooPropsMixin
          { Map get props;

            var bar, // line comment
                baz, /* inline comment*/ qux;
          }
        ''');
        verifyNoErrors();
      });
    });
  });
}


class MockTransformLogger extends Mock implements TransformLogger {
  noSuchMethod(i) => super.noSuchMethod(i);
}
