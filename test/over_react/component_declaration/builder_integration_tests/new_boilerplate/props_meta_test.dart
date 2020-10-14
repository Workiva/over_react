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

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'props_meta_test.over_react.g.dart';

main() {
  group('propsMeta', () {
    const expectedKeys = ['TestPropsMixin.test', 'FooPropsMixin.foo', 'BazPropsMixin.baz'];
    const metas = [_$metaForTestPropsMixin, _$metaForFooPropsMixin, _$metaForBazPropsMixin];
    const emptyPropsMeta = PropsMeta(fields: [], keys: []);

    group('(class)', () {
      test('provides access to the expected  props', () {
        final keys = [];
        final props = [];
        for (final meta in metas) {
          expect(meta.keys.length, 1);
          keys.add(meta.keys.first);

          expect(meta.props.length, 1);
          props.add(meta.props.first);
        }

        expect(keys, expectedKeys);
        expect(props.map((descriptor) => descriptor.key), expectedKeys);
      });

      test('does not provide access to props outside of the mixin', () {
        bool testCallback(PropDescriptor prop) => prop.key == 'FooPropsMixin.foo';

        expect(_$metaForFooPropsMixin.props.where(testCallback), isNotEmpty);
        expect(_$metaForTestPropsMixin.props.where(testCallback), isEmpty,
            reason:
                'Because `foo` is part of a different mixin, metaForTestPropsMixin should not have access to it.');
      });
    });

    void commonMetaTests(PropsMetaCollection propsMeta) {
      test('provides access to the expected props', () {
        expect(propsMeta.props.length, 3);
        expect(propsMeta.props.map((prop) => prop.key), containsAll(expectedKeys));
        expect(propsMeta.keys, containsAll(expectedKeys));
      });

      test('provides access to the expected meta', () {
        final keys = [];

        [TestPropsMixin, FooPropsMixin, BazPropsMixin].forEach((mixinType) {
          final metaForMixin = propsMeta.forMixin(mixinType);

          expect(metaForMixin.keys.length, 1);
          keys.add(metaForMixin.keys.first);
        });

        expect(keys, containsAll(expectedKeys));
      });

      group('does not provide access to props outside of the mixin', () {
        test('and throws an AssertionError in DDC', () {
          expect(
              () => propsMeta.forMixin(WoopsMixin),
              throwsA(allOf(
                isA<AssertionError>(),
                hasToStringValue(contains('No meta found for WoopsMixin')),
              )));
        }, tags: 'ddc');

        test('and returns an empty meta in dart2js', () {
          final value = propsMeta.forMixin(WoopsMixin);
          expect(value.keys, isEmpty);
          expect(value.fields, isEmpty);
        }, tags: 'no-ddc');
      });

      test('`all` provides metas for all mixins', () {
        expect(propsMeta.all, unorderedEquals(metas));
      });

      group('`forMixins`', () {
        test('provides access to the given metas', () {
          final mixins = {TestPropsMixin, FooPropsMixin};
          expect(mixins, hasLength(lessThan(propsMeta.all.length)),
              reason: 'test setup check: we need to pass in a subset of the mixins');

          expect(propsMeta.forMixins(mixins), unorderedEquals(mixins.map(propsMeta.forMixin)));
        });

        group('does not provide access to props outside of the mixin', () {
          test('and throws an AssertionError in DDC', () {
            expect(
                () => propsMeta.forMixins({WoopsMixin, TestPropsMixin}),
                throwsA(allOf(
                  isA<AssertionError>(),
                  hasToStringValue(contains('No meta found for WoopsMixin')),
                )));
          }, tags: 'ddc');

          test('and ignores those values in dart2js', () {
            final value = propsMeta.forMixins({WoopsMixin, TestPropsMixin});
            expect(value, unorderedEquals([emptyPropsMeta, propsMeta.forMixin(TestPropsMixin)]));
          }, tags: 'no-ddc');
        });
      });

      group('`allExceptForMixins`', () {
        test('provides access to all metas except for blacklisted ones', () {
          final mixins = {TestPropsMixin, FooPropsMixin};
          expect(mixins, hasLength(lessThan(propsMeta.all.length)),
              reason: 'test setup check: we need to pass in a subset of the mixins');

          expect(propsMeta.allExceptForMixins(mixins),
              unorderedEquals([propsMeta.forMixin(BazPropsMixin)]));
        });

        group('does not provide access to props outside of the mixin', () {
          test('and throws an AssertionError in DDC', () {
            expect(
                () => propsMeta.allExceptForMixins({WoopsMixin, TestPropsMixin}),
                throwsA(allOf(
                  isA<AssertionError>(),
                  hasToStringValue(contains('No meta found for WoopsMixin')),
                )));
          }, tags: 'ddc');

          test('and ignores those values in dart2js', () {
            final value = propsMeta.allExceptForMixins({WoopsMixin, TestPropsMixin});
            expect(value, unorderedEquals([FooPropsMixin, BazPropsMixin].map(propsMeta.forMixin)));
          }, tags: 'no-ddc');
        });
      });
    }

    group('(field)', () {
      commonMetaTests(_$TestComponent().propsMeta);
    });

    group('(props instance)', () {
      group('generates props meta utilities attached to the props instance', () {
        group('that can be accessed', () {
          test(r'directly via $meta', () {
            expect(Test().$meta, isNotNull);
            expect(Test().$meta, isA<PropsMetaCollection>());
          });

          test('via explicitly using the UiPropsMeta extension method', () {
            expect(UiPropsMeta(Test()).meta, isNotNull);
            expect(UiPropsMeta(Test()).meta, isA<PropsMetaCollection>());
          });
        });
      });

      commonMetaTests(UiPropsMeta(Test()).meta);
    });
  });
}

UiFactory<TestProps> Test = _$Test;

mixin TestPropsMixin on UiProps {
  String test;
}

mixin FooPropsMixin on UiProps {
  bool foo;
}

mixin BazPropsMixin on UiProps {
  bool baz;
}

mixin WoopsMixin on UiProps {
  String isNotIncluded;
}

class TestProps = UiProps with TestPropsMixin, FooPropsMixin, BazPropsMixin;

class TestComponent extends UiComponent2<TestProps> {
  @override
  render() => Dom.div()(props.foo);
}
