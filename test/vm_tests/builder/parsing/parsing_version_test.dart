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
import 'package:over_react/src/builder/parsing.dart';
import 'package:test/test.dart';

import 'parsing_helpers.dart';

main() {
  group('Version (Parsing)', () {
    Iterable<BoilerplateMember> members;

    tearDown(() {
      members = null;
    });

    group('resolveVersion', () {
      group('returns the correct version -', () {
        test('v2_legacyBackwordsCompat', () {
          members = BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v2);
          expect(resolveVersion(members).version, Version.v2_legacyBackwardsCompat);
        });

        test('v3_legacyDart2Only', () {
          members = BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v3);

          expect(resolveVersion(members).version, Version.v3_legacyDart2Only);
        });

        test('v4_mixinBased', () {
           members = BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v4);
           expect(resolveVersion(members).version, Version.v4_mixinBased);
        });
      });
    });

    group('Version', () {
      group('isLegacy', () {
        test('detects legacy instances correctly', () {
          final legacy1Members = BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v2);
          final legacy2Members = BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v3);

          expect(resolveVersion(legacy1Members).version.isLegacy, isTrue);
          expect(resolveVersion(legacy2Members).version.isLegacy, isTrue);
        });

        test('detects non-legacy instances correctly', () {
           final newBoilerplateMembers = BoilerplateMemberHelper.getBoilerplateMembersForVersion(BoilerplateVersions.v4);
           expect(resolveVersion(newBoilerplateMembers).version.isLegacy, isFalse);
        });
      });
    });

    group('VersionConfidence', () {
      VersionConfidence versionConfidence;
      VersionConfidence otherVersionConfidence;

      setUp(() {
        versionConfidence = VersionConfidence(
            v2_legacyBackwardsCompat: Confidence.unlikely,
            v3_legacyDart2Only: Confidence.unlikely,
            v4_mixinBased: Confidence.likely);

        otherVersionConfidence = VersionConfidence(
            v2_legacyBackwardsCompat: Confidence.likely,
            v3_legacyDart2Only: Confidence.neutral,
            v4_mixinBased: Confidence.unlikely);
      });

      test('toList returns a list of VersionConfidencePairs', () {
        final pairs = versionConfidence.toList();
        final testedVersions = {
          Version.v2_legacyBackwardsCompat: false,
          Version.v3_legacyDart2Only: false,
          Version.v4_mixinBased: false,
        };

        // Hard code the current number of cases expected to flag the need
        // to update this test if versions are added or removed
        expect(Version.values.length, 3);
        expect(pairs.length, Version.values.length);

        // Test to make sure all values returned from `toList()` are as expected
        for (final pair in pairs) {
          switch (pair.version) {
            case Version.v2_legacyBackwardsCompat:
              testedVersions[Version.v2_legacyBackwardsCompat] = true;
              expect(pair.confidence, Confidence.unlikely);
              break;
            case Version.v3_legacyDart2Only:
              testedVersions[Version.v3_legacyDart2Only] = true;
              expect(pair.confidence, Confidence.unlikely);
              break;
            case Version.v4_mixinBased:
              testedVersions[Version.v4_mixinBased] = true;
              expect(pair.confidence, Confidence.likely);
              break;
          }
        }

        // Verify that all expected versions were detected and tested
        testedVersions.forEach((_, v) => expect(v, isTrue));
      });

      test('+ (operator) adds together two VersionConfidence instances as expected', () {
        final addedVersionConfidence = versionConfidence + otherVersionConfidence;

        expect(addedVersionConfidence.v2_legacyBackwardsCompat, Confidence.likely + Confidence.unlikely);
        expect(addedVersionConfidence.v3_legacyDart2Only, Confidence.neutral + Confidence.unlikely);
        expect(addedVersionConfidence.v4_mixinBased, Confidence.unlikely + Confidence.likely);
      });

      group('maxConfidence returns the', () {
        test('highest confidence', () {
          final highestVersionConfidence = versionConfidence.maxConfidence;
          final otherHighestVersionConfidence = otherVersionConfidence.maxConfidence;

          expect(highestVersionConfidence.version, Version.v4_mixinBased);
          expect(otherHighestVersionConfidence.version, Version.v2_legacyBackwardsCompat);
        });

        group('higher priority confidence when two are equal', () {
          test('', () {
            final highestAfterAdding = (versionConfidence + otherVersionConfidence).maxConfidence;

            expect(highestAfterAdding.version, Version.v4_mixinBased);
          });

          test('and the priority is as expected', () {
            final ambiguousVersion = VersionConfidence.all(Confidence.neutral);
            expect(ambiguousVersion.maxConfidence.version, Version.v4_mixinBased);

            final versionWithoutMixin = VersionConfidence(
                v2_legacyBackwardsCompat: Confidence.neutral,
                v3_legacyDart2Only: Confidence.neutral,
                v4_mixinBased: Confidence.none);
            expect(versionWithoutMixin.maxConfidence.version, Version.v2_legacyBackwardsCompat);
          });
        });
      });

      group('toString returns', () {
        test('all versions', () {
          expect(
              versionConfidence.toString(),
              contains(
                  '{v2_legacyBackwardsCompat: ${Confidence.unlikely}, v3_legacyDart2Only: ${Confidence.unlikely}, v4_mixinBased: ${Confidence.likely}}'));
        });

        test('runtime type', () {
          expect(versionConfidence.toString(), contains('VersionConfidence'));
        });
      });
    });

    group('VersionPair', () {
      test('shouldGenerate will only return true if confidence is higher than medium', () {
        final confidentVersion = VersionConfidence(
                v2_legacyBackwardsCompat: Confidence.unlikely,
                v3_legacyDart2Only: Confidence.unlikely,
                v4_mixinBased: Confidence.likely)
            .maxConfidence;
        expect(confidentVersion.shouldGenerate, isTrue);

        final moderatelyConfidentVersion = VersionConfidence.all(Confidence.neutral).maxConfidence;
        expect(moderatelyConfidentVersion.shouldGenerate, isFalse);

        final notConfidentVersion = VersionConfidence.none().maxConfidence;
        expect(notConfidentVersion.shouldGenerate, isFalse);
      });
    });
  });
}
