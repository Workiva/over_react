// Copyright 2017 Workiva Inc.
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
library transformer_test;

import 'dart:io';

import 'package:barback/barback.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:over_react/transformer.dart';

main() {
  final Matcher isDartFile = predicate((Asset asset) => asset.id.extension == '.dart');

  group('over_react transformer', () {
    WebSkinDartTransformer initWithConfig(Map config) =>
        new WebSkinDartTransformer.asPlugin(new BarbackSettings(config, BarbackMode.DEBUG));

    test('removes \$props|\$state mixins from with clause when un-prefixed version is found', () async {
      final originalPropsWithClause = 'with FooPropsMixin,\n'
          '// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.\n'
          '// ignore: mixin_of_non_class,undefined_class\n'
          '\$FooPropsMixin, BarPropsMixin, \$FizzPropsMixin, \$BarPropsMixin';
      final originalStateWithClause = 'with FooStateMixin,\n'
          '// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.\n'
          '// ignore: mixin_of_non_class,undefined_class\n'
          '\$FooStateMixin';
      // $FizzPropsMixin is expected remain since it does not have a un-prefixed version in the
      // the props class with clause.
      final transformedPropsWithClause = 'with FooPropsMixin,\n'
          '// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.\n'
          '// ignore: mixin_of_non_class,undefined_class\n'
          'BarPropsMixin, \$FizzPropsMixin ';
      final transformedStateWithClause = 'with FooStateMixin\n'
          '// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.\n'
          '// ignore: mixin_of_non_class,undefined_class\n'
          ' ';
      AssetId fakeInputFileAssetId = new AssetId('testId', 'component_with_prefixed_mixins.dart');

      MockAsset inputFile;
      MockTransform mockTransform;

      inputFile = new MockAsset();
      mockTransform = new MockTransform();

      when(inputFile.id).thenReturn(fakeInputFileAssetId);
      when(mockTransform.primaryInput).thenReturn(inputFile);
      when(inputFile.readAsString()).thenReturn(new File.fromUri(Uri.parse('test/vm_tests/transformer/test_data/component_with_prefixed_mixins.dart')).readAsString());

      await initWithConfig({}).apply(mockTransform);

      Asset fileAssets = verify(mockTransform.addOutput(captureThat(isDartFile))).captured.first;
      String assetContent = await fileAssets.readAsString();

      expect(fileAssets.id.toString(), equals('testId|component_with_prefixed_mixins.dart'));
      expect(assetContent, isNot(contains(originalPropsWithClause)));
      expect(assetContent, isNot(contains(originalStateWithClause)));
      expect(assetContent, contains(transformedPropsWithClause));
      expect(assetContent, contains(transformedStateWithClause));
    });

    test('removes \$ prefixed mixins from with clause of unannotated classes', () async {
      final originalWithClause = 'with FooPropsMixin,\n'
          '// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.\n'
          '// ignore: mixin_of_non_class,undefined_class\n'
          '\$FooPropsMixin, BarPropsMixin, \$BarPropsMixin';
      final transformedWithClause = 'with FooPropsMixin,\n'
          '// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.\n'
          '// ignore: mixin_of_non_class,undefined_class\n'
          'BarPropsMixin';
      AssetId fakeInputFileAssetId = new AssetId('testId', 'class_with_prefixed_mixins.dart');

      MockAsset inputFile;
      MockTransform mockTransform;

      inputFile = new MockAsset();
      mockTransform = new MockTransform();

      when(inputFile.id).thenReturn(fakeInputFileAssetId);
      when(mockTransform.primaryInput).thenReturn(inputFile);
      when(inputFile.readAsString()).thenReturn(new File.fromUri(Uri.parse('test/vm_tests/transformer/test_data/class_with_prefixed_mixins.dart')).readAsString());

      await initWithConfig({}).apply(mockTransform);

      Asset fileAssets = verify(mockTransform.addOutput(captureThat(isDartFile))).captured.first;
      String assetContent = await fileAssets.readAsString();

      expect(fileAssets.id.toString(), equals('testId|class_with_prefixed_mixins.dart'));
      expect(assetContent, isNot(contains(originalWithClause)));
      expect(assetContent, contains(transformedWithClause));
    });

    group('loads config value:', () {
      group('"fixDdcAbstractAccessors"', () {
        const String configKey = 'fixDdcAbstractAccessors';

        test('when specified as a boolean', () {
          expect(() => initWithConfig({configKey: true}), returnsNormally);
          expect(() => initWithConfig({configKey: false}), returnsNormally);
        });

        test('when not specified', () {
          expect(() => initWithConfig({}), returnsNormally);
          expect(() => initWithConfig({configKey: null}), returnsNormally);
        });

        test('and throws when specified with an invalid value', () {
          expect(() => initWithConfig({configKey: 'foo'}), throwsArgumentError);
          expect(() => initWithConfig({configKey: []}), throwsArgumentError);
        });
      });
    });
  });
}

// Transformer Mocks
class MockAsset extends Mock implements Asset {}
class MockTransform extends Mock implements Transform {}
