// Copyright 2020 Workiva Inc.
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
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:mockito/mockito.dart';
import 'package:over_react/src/builder/parsing.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import '../util.dart';

main() {
  group('parsing validation -', () {
    group('ErrorCollector', () {
      ErrorCollector collector;
      SourceFile file;
      MockLogger logger;

      const boilerplateString = r'''
              @Factory()
              UiFactory<FooProps> Foo = _$Foo;
      
              @Props()
              class _$FooProps extends UiProps {}
      
              @State()
              class _$FooState extends _$FooState with _$FooStateAccessorsMixin {}
      
              @Component2()
              class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
            ''';

      const message = 'a very unique message';

      tearDown(() {
        collector = null;
        file = null;
        logger = null;
      });

      group('utilities', () {
        group('stringCallback', () {
          Function(String, [SourceSpan]) callback;
          String callbackResult;

          setUp(() {
            file = SourceFile.fromString(boilerplateString);

            callback = ErrorCollector.stringCallback((spanMessage) {
              callbackResult = spanMessage;
            });
          });

          tearDown(() {
            callbackResult = null;
          });

          test('can be used to generate a string', () {
            callback('test message');

            expect(callbackResult, contains('test message'));
          });

          test('can be used to generate a string with a span', () {
            callback('test message', file.span(0, file.getOffset(2)));

            expect(callbackResult, contains('test message'));
            expect(callbackResult, contains('@Factory()'));
            expect(callbackResult, contains(r'UiFactory<FooProps> Foo = _$Foo'));
          });
        });

        group('spanFor returns the expected span', () {
          setUp(() {
            file = SourceFile.fromString(boilerplateString);
            collector = ErrorCollector.print(file);
          });

          tearDown(() {
            file = null;
            collector = null;
          });

          test('when the unit is a SyntacticEntity', () {
            final localFileParseResult = parseString(content: boilerplateString);
            final propsNameToken = localFileParseResult.unit.childEntities
                .whereType<ClassOrMixinDeclaration>()
                .first
                .name;

            final localFileSpan = file.spanFor(propsNameToken);
            final collectorFileSpan = collector.spanFor(propsNameToken);

            // Sanity check
            expect(localFileSpan.text, r'_$FooProps');

            expect(collectorFileSpan.text, r'_$FooProps');
            expect(collectorFileSpan.text, localFileSpan.text);
          });

          test('when the unit is a Token', () {
            final localFileParseResult = parseString(content: boilerplateString);
            final beginToken = localFileParseResult.unit.beginToken;

            final localFileSpan = file.spanFor(beginToken);
            final collectorFileSpan = collector.spanFor(beginToken);

            // Sanity check
            expect(localFileSpan.text, r'@');

            expect(collectorFileSpan.text, r'@');
            expect(collectorFileSpan.text, localFileSpan.text);
          });
        });

        test('span returns the expected span', () {
          file = SourceFile.fromString(boilerplateString);
          collector = ErrorCollector.print(file);

          addTearDown(() {
            file = null;
            collector = null;
          });

          final expectedSpan = file.span(0, 25);

          // Sanity check
          expect(expectedSpan.text, contains('@Factory'));

          expect(collector.span(0, 25), expectedSpan);
        });
      });

      group('callback', () {
        var errorList = <String>[];
        var warnList = <String>[];

        setUp(() {
          file = SourceFile.fromString(boilerplateString);

          void customError(String message, [SourceSpan span]) {
            errorList.add('CUSTOM ERROR MESSAGE: $message; ${span?.text}');
          }

          void customWarning(String message, [SourceSpan span]) {
            warnList.add('CUSTOM WARNING MESSAGE: $message; ${span?.text}');
          }

          collector = ErrorCollector.callback(file, onError: customError, onWarning: customWarning);
        });

        tearDown(() {
          errorList = <String>[];
          warnList = <String>[];
        });

        group('will print', () {
          test('errors', () {
            collector.addError(message);
            expect(errorList.first, contains('CUSTOM ERROR MESSAGE'));
            expect(errorList.first, contains(message));
          });

          test('warnings', () {
            collector.addWarning(message);
            expect(warnList.first, contains('CUSTOM WARNING MESSAGE'));
            expect(warnList.first, contains(message));
          });
        });

        group('logs a span correctly for', () {
          test('errors', () {
            collector.addError(message, file.span(0, file.getOffset(2)));
            expect(errorList.first, contains('CUSTOM ERROR MESSAGE'));
            expect(errorList.first, contains(message));
            expect(errorList.first, contains('@Factory()'));
          });

          test('warnings', () {
            collector.addWarning(message, file.span(0, file.getOffset(2)));
            expect(warnList.first, contains('CUSTOM WARNING MESSAGE'));
            expect(warnList.first, contains(message));
            expect(warnList.first, contains('@Factory()'));
          });
        });
      });

      group('print', () {
        setUp(() {
          file = SourceFile.fromString(boilerplateString);
          collector = ErrorCollector.print(file);
        });

        group('will print', () {
          test('correctly prints errors', () {
            expect(() => collector.addError(message), prints(contains(message)));
          });

          test('correctly prints warnings', () {
            expect(() => collector.addWarning('warning: $message'),
                prints(contains('warning: $message')));
          });
        });

        group('logs a span correctly for', () {
          test('errors', () {
            var expectedOutput = '';

            final callbackTest = ErrorCollector.stringCallback((generatedString) {
              expectedOutput = generatedString;
            });

            // Create the string that is expected
            callbackTest(message, file.span(0, file.getOffset(2)));

            // Look for the expected output
            expect(() => collector.addError(message, file.span(0, file.getOffset(2))),
                prints(contains(expectedOutput)));
          });

          test('warnings', () {
            var expectedOutput = '';

            final callbackTest = ErrorCollector.stringCallback((generatedString) {
              expectedOutput = generatedString;
            });

            // Create the string that is expected
            callbackTest('warning: $message', file.span(0, file.getOffset(2)));

            // Look for the expected output
            expect(() => collector.addWarning('warning: $message', file.span(0, file.getOffset(2))),
                prints(contains('$expectedOutput')));
          });
        });
      });

      group('log', () {
        setUp(() {
          logger = MockLogger();
          file = SourceFile.fromString(boilerplateString);

          collector = ErrorCollector.log(file, logger);
        });

        group('will print', () {
          test('correctly prints errors', () {
            collector.addError(message);
            verify(logger.severe(message));
          });

          test('correctly prints warnings', () {
            collector.addWarning(message);
            verify(logger.warning(contains(message)));
          });
        });

        group('logs a span correctly for', () {
          test('errors', () {
            var expectedOutput = '';

            final callbackTest = ErrorCollector.stringCallback((generatedString) {
              expectedOutput = generatedString;
            });

            // Create the string that is expected
            callbackTest(message, file.span(0, file.getOffset(2)));

            // Add the warning
            collector.addError(message, file.span(0, file.getOffset(2)));

            // Look for the expected output
            verify(logger.severe(expectedOutput));
          });

          test('warnings', () {
            var expectedOutput = '';

            final callbackTest = ErrorCollector.stringCallback((generatedString) {
              expectedOutput = generatedString;
            });

            // Create the string that is expected
            callbackTest(message, file.span(0, file.getOffset(2)));

            // Add the warning
            collector.addWarning(message, file.span(0, file.getOffset(2)));

            // Look for the expected output
            verify(logger.warning(expectedOutput));
          });
        });
      });
    });
  });
}
