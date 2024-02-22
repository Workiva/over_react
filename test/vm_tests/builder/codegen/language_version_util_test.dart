// @dart=2.11
// Copyright 2023 Workiva Inc.
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
import 'package:over_react/src/builder/codegen/language_version_util.dart';
import 'package:package_config/package_config.dart';
import 'package:test/test.dart';

main() {
  group('language version utils -', () {
    const nonNullSafeTestLanguageVersions = {
      '1.0',
      '2.0',
      '2.9',
      '2.11',
    };
    const nullSafeTestLanguageVersions = {
      '2.12',
      '2.13',
      '2.18',
      '3.0',
      '3.2',
    };

    void sharedTests(bool Function(String version) supportsNullSafety) {
      group('returns false for language versions that are null safe:', () {
        for (final version in nonNullSafeTestLanguageVersions) {
          test(version, () => expect(supportsNullSafety(version), isFalse));
        }
      });

      group('returns true for language versions that are null safe:', () {
        for (final version in nullSafeTestLanguageVersions) {
          test(version, () => expect(supportsNullSafety(version), isTrue));
        }
      });
    }

    group('LanguageVersionToken.supportsNullSafety', () {
      sharedTests((version) {
        // Ignore diagnostics for higher language versions than what's supported for the current
        // Dart SDK version
        return parseString(content: '//@dart=$version', throwIfDiagnostics: false)
            .unit
            .languageVersionToken
            .supportsNullSafety;
      });
    });

    group('LanguageVersion.supportsNullSafety', () {
      sharedTests((version) => LanguageVersion.parse(version).supportsNullSafety);
    });
  });
}
