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
import 'package:over_react/src/builder/codegen/names.dart';
import 'package:test/test.dart';

main() {
  group('boilerplate name utilities -', () {
    group('FactoryNames -', () {
      FactoryNames names;

      group('unprefixed -', () {
        setUp(() {
          names = FactoryNames('Foo');
        });

        test('consumerName', () => expect(names.consumerName, r'Foo'));
        test('implName', () => expect(names.implName, r'_$Foo'));
      });

      group('prefixed -', () {
        setUp(() {
          names = FactoryNames('foo.Foo');
        });

        test('consumerName', () => expect(names.consumerName, r'foo.Foo'));
        test('implName', () => expect(names.implName, r'foo._$Foo'));
      });
    });

    group('ComponentNames -', () {
      ComponentNames names;

      group('unprefixed -', () {
        setUp(() {
          names = ComponentNames('FooComponent');
        });

        test('consumerName', () => expect(names.consumerName, r'FooComponent'));
        test('componentFactoryName', () => expect(names.componentFactoryName, r'$FooComponentFactory'));
        test('implName', () => expect(names.implName, r'_$FooComponent'));
      });

      group('prefixed -', () {
        setUp(() {
          names = ComponentNames('foo.FooComponent');
        });

        test('consumerName', () => expect(names.consumerName, r'foo.FooComponent'));
        test('componentFactoryName', () => expect(names.componentFactoryName, r'foo.$FooComponentFactory'));
        test('implName', () => expect(names.implName, r'foo._$FooComponent'));
      });
    });

    group('TypedMapNames -', () {
      TypedMapNames names;

      group('unprefixed,', () {
        group('legacy boilerplate -', () {
          setUp(() {
            names = TypedMapNames(r'_$FooProps');
          });

          test('consumerName', () => expect(names.consumerName, r'_$FooProps'));
          test('implName', () => expect(names.implName, r'_$$FooProps'));
          test('plainMapImplName', () => expect(names.plainMapImplName, r'_$$FooProps$PlainMap'));
          test('jsMapImplName', () => expect(names.jsMapImplName, r'_$$FooProps$JsMap'));
          test('publicName', () => expect(names.publicName, r'FooProps'));
          test('legacyAccessorsMixinName', () => expect(names.legacyAccessorsMixinName, r'_$FooPropsAccessorsMixin'));
          test('generatedMixinName', () => expect(names.generatedMixinName, r'FooProps'));
          test('publicGeneratedMetaName', () => expect(names.publicGeneratedMetaName, r'FooProps.meta'));
          test('metaConstantName', () => expect(names.metaConstantName, r'_$metaForFooProps'));
        });

        group('new boilerplate -', () {
          setUp(() {
            names = TypedMapNames('FooProps');
          });

          test('consumerName', () => expect(names.consumerName, r'FooProps'));
          test('implName', () => expect(names.implName, r'_$$FooProps'));
          test('plainMapImplName', () => expect(names.plainMapImplName, r'_$$FooProps$PlainMap'));
          test('jsMapImplName', () => expect(names.jsMapImplName, r'_$$FooProps$JsMap'));
          test('publicName', () => expect(names.publicName, r'FooProps'));
          // legacyAccessorsMixinName not applicable
          test('generatedMixinName', () => expect(names.generatedMixinName, r'$FooProps'));
          test('publicGeneratedMetaName', () => expect(names.publicGeneratedMetaName, r'$FooProps.meta'));
          test('metaConstantName', () => expect(names.metaConstantName, r'_$metaForFooProps'));
        });
      });

      group('prefixed,', () {
        group('legacy boilerplate -', () {
          setUp(() {
            names = TypedMapNames(r'foo._$FooProps');
          });

          test('consumerName', () => expect(names.consumerName, r'foo._$FooProps'));
          test('implName', () => expect(names.implName, r'foo._$$FooProps'));
          test('plainMapImplName', () => expect(names.plainMapImplName, r'foo._$$FooProps$PlainMap'));
          test('jsMapImplName', () => expect(names.jsMapImplName, r'foo._$$FooProps$JsMap'));
          test('publicName', () => expect(names.publicName, r'foo.FooProps'));
          test('legacyAccessorsMixinName', () => expect(names.legacyAccessorsMixinName, r'foo._$FooPropsAccessorsMixin'));
          test('generatedMixinName', () => expect(names.generatedMixinName, r'foo.FooProps'));
          test('publicGeneratedMetaName', () => expect(names.publicGeneratedMetaName, r'foo.FooProps.meta'));
          test('metaConstantName', () => expect(names.metaConstantName, r'foo._$metaForFooProps'));
        });

        group('new boilerplate -', () {
          setUp(() {
            names = TypedMapNames('foo.FooProps');
          });

          test('consumerName', () => expect(names.consumerName, r'foo.FooProps'));
          test('implName', () => expect(names.implName, r'foo._$$FooProps'));
          test('plainMapImplName', () => expect(names.plainMapImplName, r'foo._$$FooProps$PlainMap'));
          test('jsMapImplName', () => expect(names.jsMapImplName, r'foo._$$FooProps$JsMap'));
          test('publicName', () => expect(names.publicName, r'foo.FooProps'));
          // legacyAccessorsMixinName not applicable
          test('generatedMixinName', () => expect(names.generatedMixinName, r'foo.$FooProps'));
          test('publicGeneratedMetaName', () => expect(names.publicGeneratedMetaName, r'foo.$FooProps.meta'));
          test('metaConstantName', () => expect(names.metaConstantName, r'foo._$metaForFooProps'));
        });
      });
    });
  });
}
