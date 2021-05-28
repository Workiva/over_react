// Copyright 2016 Workiva Inc.
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

@TestOn('browser')

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

part 'props_map_view_test.over_react.g.dart';

main() {
  group('props map view integration:', () {
    group('initializes the factory variable with a function', () {
      test('that returns a new props class implementation instance', () {
        var instance = Test();
        expect(instance, isA<TestProps>());
        expect(instance, isA<Map>());
      });

      test('that returns a new props class implementation instance backed by an existing map', () {
        Map existingMap = {'TestProps.stringProp': 'test'};
        var props = Test(existingMap);

        expect(props.stringProp, equals('test'));

        props.stringProp = 'modified';
        expect(props.stringProp, equals('modified'));
        expect(existingMap['TestProps.stringProp'], equals('modified'));
      });
    });

    group('generates prop getters/setters with', () {
      test('the props class name as a namespace and the prop name as the key by default', () {
        expect(Test()..stringProp = 'test',
            containsPair('TestProps.stringProp', 'test'));

        expect(Test()..dynamicProp = 2,
            containsPair('TestProps.dynamicProp', 2));

        expect(Test()..untypedProp = false,
            containsPair('TestProps.untypedProp', false));

      });

      test('custom prop keys', () {
        expect(Test()..customKeyProp = 'test',
            containsPair('TestProps.custom key!', 'test'));
      });

      test('custom prop key namespaces', () {
        expect(Test()..customNamespaceProp = 'test',
            containsPair('custom namespace~~customNamespaceProp', 'test'));
      });

      test('custom prop keys and namespaces', () {
        expect(Test()..customKeyAndNamespaceProp = 'test',
            containsPair('custom namespace~~custom key!', 'test'));
      });

      test('returns an empty map for componentDefaultProps', () {
        expect(Test().componentDefaultProps, equals({}));
      });
    });

    test('raises an assertion when invoked via call/build, since it has no componentFactory', () {
      expect(() => Test()(), throwsA(isA<AssertionError>()));
      expect(() => Test().build(), throwsA(isA<AssertionError>()));
    }, tags: 'ddc');

    test('throws a null error when invoked via call/build, since it has no componentFactory', () {
      expect(() => Test()(), throwsNoSuchMethodError);
      expect(() => Test().build(), throwsNoSuchMethodError);
    }, tags: 'no-ddc');
  });
}

UiFactory<TestProps> Test = _$Test; // ignore: undefined_identifier, invalid_assignment

mixin TestProps on UiProps {
  String? stringProp;
  dynamic dynamicProp;
  var untypedProp; // ignore: prefer_typing_uninitialized_variables

  @Accessor(key: 'custom key!')
  dynamic customKeyProp;

  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic customNamespaceProp;

  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic customKeyAndNamespaceProp;
}
