library pretty_print_test;

import 'package:test/test.dart';
import 'package:over_react/src/util/pretty_print.dart';
import 'package:over_react/src/util/string_util.dart';

/// Main entrypoint for pretty_print testing
main() {
  group('pretty_print library', () {
    group('prettyPrintMap properly formats', () {
      test('an empty map', () {
        expect(prettyPrintMap({}), '{}');
      });

      test('a map with a single key-value pair', () {
        expect(prettyPrintMap({'foo': 'bar'}), '{foo: bar}');
      });

      test('a map with more than one key-value pairs', () {
        expect(prettyPrintMap({
          'foo': 'bar',
          'bar': 'foo'
        }), unindent(
            '''
            {
              foo: bar,
              bar: foo
            }
            '''
        ));
      });

      test('a map with a single key-value pair and a small list', () {
        expect(prettyPrintMap({
          'foo': [1, 2, 3]
        }), '{foo: [1, 2, 3]}');
      });

      test('a map with a single key-value pair and a list with length >4', () {
        expect(prettyPrintMap({
          'foo': [1, 2, 3, 4, 5]
        }), unindent(
            '''
            {
              foo: [
                1,
                2,
                3,
                4,
                5
              ]
            }
            '''
        ));
      });

      test('a map with nested maps, one key-value-pair per map', () {
        expect(prettyPrintMap({
          'foo': {'bar': 'baz'}
        }), '{foo: {bar: baz}}');
      });

      test('a map with a nested multi-pair maps', () {
        expect(prettyPrintMap({
          'foo': {'bar': 'baz', 1: 2}
        }), unindent(
            '''
            {
              foo: {
                bar: baz,
                1: 2
              }
            }
            '''
        ));
      });

      test('a map with a single namespaced key', () {
        expect(prettyPrintMap({
          'Foo.bar': true
        }), unindent(
            '''
            {
              Foo…
                .bar: true
            }
            '''
        ));
      });

      test('a map with a multiple keys of the same namespace', () {
        expect(prettyPrintMap({
          'Foo.bar': true,
          'Foo.baz': false
        }), unindent(
            '''
            {
              Foo…
                .bar: true,
                .baz: false
            }
            '''
        ));
      });


      test('a map with a multiple keys with different namespaces', () {
        expect(prettyPrintMap({
          'Foo.bar': true,
          'Bar.foo': 1
        }), unindent(
            '''
            {
              Foo…
                .bar: true,

              Bar…
                .foo: 1
            }
            '''
        ));
      });

      test('a map with a multiple keys in multiple namespaces', () {
        expect(prettyPrintMap({
          'Foo.bar': true,
          'Foo.baz': false,
          'Bar.foo': 1,
          'Bar.baz': 2,
        }), unindent(
            '''
            {
              Foo…
                .bar: true,
                .baz: false,

              Bar…
                .foo: 1,
                .baz: 2
            }
            '''
        ));
      });

      test('a map with a multiple keys in multiple namespaces and several unnamespaced keys', () {
        expect(prettyPrintMap({
          'Foo.bar': true,
          'Foo.baz': false,
          'Bar.foo': 1,
          'Bar.baz': 2,
          'foo': [],
          'bar': null
        }), unindent(
            '''
            {
              Foo…
                .bar: true,
                .baz: false,

              Bar…
                .foo: 1,
                .baz: 2,

              foo: [],
              bar: null
            }
            '''
        ));
      });

      test('a map with a nested namespaced keys', () {
        expect(prettyPrintMap({
          'Foo.bar': {
            'Bar.foo': 1,
          }
        }), unindent(
            '''
            {
              Foo…
                .bar: {
                  Bar…
                    .foo: 1
                }
            }
            '''
        ));
      });
    });
  });
}
