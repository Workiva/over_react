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

    group('(class)', () {
      const metas = [_$metaForTestPropsMixin, _$metaForFooPropsMixin, _$metaForBazPropsMixin];

      test('provides access to the expected props', () {
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

    group('(field)', () {
      final propsMeta = _$TestComponent().propsMeta;

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
