// Copyright 2024 Workiva Inc.
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
library over_react.test.get_defaulted_prop_names_test;

import 'package:over_react/src/builder/parsing.dart' show getDefaultedPropNames;
import 'package:test/test.dart';

import '../../ast_test_util.dart';

void main() {
  group('getDefaultedPropNames', () {
    group('returns defaulted props assigned in', () {
      test('defaultProps', () {
        final component = parseAndGetSingleClassish(/*language=dart*/ r'''
          class FooComponent extends UiComponent2 {
            @override
            get defaultProps => (newProps()
              ..foo = 1
              ..bar = 2
            );
          }
        ''');
        expect(getDefaultedPropNames(component), unorderedEquals({'foo', 'bar'}));
      });

      test('getDefaultProps', () {
        final component = parseAndGetSingleClassish(/*language=dart*/ r'''
          class FooComponent extends UiComponent {
            @override
            getDefaultProps() => (newProps()
              ..foo = 1
              ..bar = 2
            );
          }
        ''');
        expect(getDefaultedPropNames(component), unorderedEquals({'foo', 'bar'}));
      });
    });

    group('returns an empty set for', () {
      test('components without a default props override', () {
        final component = parseAndGetSingleClassish(/*language=dart*/ r'''
          class FooComponent extends UiComponent2 {}
        ''');
        expect(getDefaultedPropNames(component), isEmpty);
      });

      test('components with a default props override with no assignments', () {
        final component = parseAndGetSingleClassish(/*language=dart*/ r'''
          class FooComponent extends UiComponent2 {
            get defaultProps => newProps();
          }
        ''');
        expect(getDefaultedPropNames(component), isEmpty);
      });

      test('non-component classes', () {
        final nonComponent = parseAndGetSingleClassish(/*language=dart*/ r'''
          class Foo {}
        ''');
        expect(getDefaultedPropNames(nonComponent), isEmpty);
      });
    });

    group('does not include', () {
      test('prefixed props (like `dom.`)', () {
        final component = parseAndGetSingleClassish(/*language=dart*/ r'''
          class FooComponent extends UiComponent2 {
            @override
            get defaultProps => (newProps()
              ..foo = 1
              ..dom.id = 'testId'
              ..aria.hidden = true
            );
          }
        ''');
        expect(getDefaultedPropNames(component), unorderedEquals({'foo'}));
      });

      test('props that are accessed but not assigned', () {
        final component = parseAndGetSingleClassish(/*language=dart*/ r'''
          class FooComponent extends UiComponent2 {
            @override
            get defaultProps => (newProps()
              ..foo = 1
              ..bar
              ..dom.id
              ..onClick?.call()
            );
          }
        ''');
        expect(getDefaultedPropNames(component), unorderedEquals({'foo'}));
      });

      test('method calls', () {
        final component = parseAndGetSingleClassish(/*language=dart*/ r'''
          class FooComponent extends UiComponent2 {
            @override
            get defaultProps => (newProps()
              ..foo = 1
              ..addProps(someOtherProps)
              ..modifyProps((p) {
                p.bar = 2;
              })
            );
          }
        ''');
        expect(getDefaultedPropNames(component), unorderedEquals({'foo'}));
      });
    });

    group('handles different syntactic variations:', () {
      group('return value', () {
        test('not wrapped in parens', () {
          final component = parseAndGetSingleClassish(/*language=dart*/ r'''
            class FooComponent extends UiComponent2 {
              @override
              get defaultProps => newProps()
                ..foo = 1
                ..bar = 2;
            }
          ''');
          expect(getDefaultedPropNames(component), unorderedEquals({'foo', 'bar'}));
        });

        test('wrapped in parens', () {
          final component = parseAndGetSingleClassish(/*language=dart*/ r'''
            class FooComponent extends UiComponent2 {
              @override
              get defaultProps => (newProps()
                ..foo = 1
                ..bar = 2
              );
            }
          ''');
          expect(getDefaultedPropNames(component), unorderedEquals({'foo', 'bar'}));
        });

        test('wrapped in multiple parens', () {
          final component = parseAndGetSingleClassish(/*language=dart*/ r'''
            class FooComponent extends UiComponent2 {
              @override
              get defaultProps => ((newProps()
                ..foo = 1
                ..bar = 2
              ));
            }
          ''');
          expect(getDefaultedPropNames(component), unorderedEquals({'foo', 'bar'}));
        });
      });

      group('different function body types:', () {
        test('arrow function', () {
          final component = parseAndGetSingleClassish(/*language=dart*/ r'''
            class FooComponent extends UiComponent2 {
              @override
              get defaultProps => (newProps()
                ..foo = 1
                ..bar = 2
              );
            }
          ''');
          expect(getDefaultedPropNames(component), unorderedEquals({'foo', 'bar'}));
        });

        test('block function', () {
          final component = parseAndGetSingleClassish(/*language=dart*/ r'''
            class FooComponent extends UiComponent2 {
              @override
              get defaultProps {
                return (newProps()
                  ..foo = 1
                  ..bar = 2
                );
              }
            }
          ''');
          expect(getDefaultedPropNames(component), unorderedEquals({'foo', 'bar'}));
        });
      });
    });
  });
}
