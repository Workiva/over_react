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

import 'dart:async';
import 'dart:io';

import 'package:barback/barback.dart';
import 'package:mockito/mockito.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import 'package:over_react/transformer.dart';

main() {
  final Matcher isDartFile = predicate((Asset asset) => asset.id.extension == '.dart');

  group('over_react transformer', () {
    const String fakePackage = 'fake_package';

    WebSkinDartTransformer initWithConfig(Map config) =>
        new WebSkinDartTransformer.asPlugin(new BarbackSettings(config, BarbackMode.DEBUG));

    test('declares the correct input assets', () {
      expect(initWithConfig({}).isPrimary(new AssetId(fakePackage, 'web/src/demo_components/button.dart')), isTrue);
      expect(initWithConfig({}).isPrimary(new AssetId(fakePackage, 'web/src/index.html')), isFalse);
      expect(initWithConfig({}).isPrimary(new AssetId(fakePackage, 'dart_test.yaml')), isFalse);
    });

    test('outputs an empty file when dart 2 boiler plate compatible part directive is found', () async {
      AssetId fakeInputFileAssetId = new AssetId('testId', 'componentWithPartDirective.dart');

      MockAsset inputFile;
      MockTransform mockTransform;

      inputFile = new MockAsset();
      mockTransform = new MockTransform();

      when(inputFile.id).thenReturn(fakeInputFileAssetId);
      when(mockTransform.primaryInput).thenReturn(inputFile);
      when(inputFile.readAsString())
          .thenReturn(new File.fromUri(Uri.parse('test/vm_tests/transformer/test_data/componentWithPartDirective.dart')).readAsString());

      await initWithConfig({}).apply(mockTransform);

      var fileAssets = verify(mockTransform.addOutput(captureThat(isDartFile))).captured;

      expect(fileAssets.length, equals(3));
      expect(fileAssets[0].id.toString(), equals('testId|foo.over_react.g.dart'));
      expect(fileAssets[1].id.toString(), equals('testId|bar.over_react.g.dart'));
      expect(fileAssets[2].id.toString(), equals('testId|componentWithPartDirective.dart'));
      expect(fileAssets[0].toString(), equals('String ""'));
      expect(fileAssets[1].toString(), equals('String ""'));
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
