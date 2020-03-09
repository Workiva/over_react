@TestOn('vm')
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:over_react/src/builder/generation/parsing.dart';
import 'package:test/test.dart';

main() {
  group('Version (Parsing)', () {
    Iterable<BoilerplateMember> members;

    Iterable<BoilerplateMember> getBoilerplateMembers(VersionOptions version) {
      final unit = parseString(content: boilerplateStrings[version]).unit;

      return BoilerplateMembers.detect(unit).allMembers;
    }

    tearDown(() {
      members = null;
    });

    group('resolveVersion', () {
      group('returns the correct version -', () {
        test('v2_legacyBackwordsCompat', () {
          members = getBoilerplateMembers(VersionOptions.v2);
          expect(resolveVersion(members).version, Version.v2_legacyBackwardsCompat);
        });

        test('v3_legacyDart2Only', () {
          members = getBoilerplateMembers(VersionOptions.v3);

          expect(resolveVersion(members).version, Version.v3_legacyDart2Only);
        });

        // TODO uncomment test when mixin parser is implemented
        test('v4_mixinBased', () {
          // members = getBoilerplateMembers(VersionOptions.v4);
          // expect(resolveVersions(members).version, Version.v4_mixinBased);
        });
      });
    });

    group('Version', () {
      group('isLegacy', () {
        test('detects legacy instances correctly', () {
          final legacy1Members = getBoilerplateMembers(VersionOptions.v2);
          final legacy2Members = getBoilerplateMembers(VersionOptions.v3);

          expect(resolveVersion(legacy1Members).version.isLegacy, isTrue);
          expect(resolveVersion(legacy2Members).version.isLegacy, isTrue);
        });

        test('detects non-legacy instances correctly', () {
          // TODO uncomment new boilerplate members
          // final newBoilerplateMembers = getBoilerplateMembers(VersionOptions.v3);

          // expect(resolveVersion(newBoilerplateMembers).version.isLegacy, isFalse);
        });
      });
    });

    group('VersionConfidence', () {
      VersionConfidence versionConfidence;
      VersionConfidence otherVersionConfidence;

      setUp(() {
        versionConfidence = VersionConfidence(
            v2_legacyBackwardsCompat: Confidence.low,
            v3_legacyDart2Only: Confidence.low,
            v4_mixinBased: Confidence.high);

        otherVersionConfidence = VersionConfidence(
            v2_legacyBackwardsCompat: Confidence.high,
            v3_legacyDart2Only: Confidence.medium,
            v4_mixinBased: Confidence.low);
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
              expect(pair.confidence, Confidence.low);
              break;
            case Version.v3_legacyDart2Only:
              testedVersions[Version.v3_legacyDart2Only] = true;
              expect(pair.confidence, Confidence.low);
              break;
            case Version.v4_mixinBased:
              testedVersions[Version.v4_mixinBased] = true;
              expect(pair.confidence, Confidence.high);
              break;
          }
        }

        // Verify that all expected versions were detected and tested
        testedVersions.forEach((_, v) => expect(v, isTrue));
      });

      test('+ (operator) adds together two VersionConfidence instances as expected', () {
        final addedVersionConfidence = versionConfidence + otherVersionConfidence;

        expect(addedVersionConfidence.v2_legacyBackwardsCompat, Confidence.high + Confidence.low);
        expect(addedVersionConfidence.v3_legacyDart2Only, Confidence.medium + Confidence.low);
        expect(addedVersionConfidence.v4_mixinBased, Confidence.low + Confidence.high);
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
            final ambiguousVersion = VersionConfidence.all(Confidence.medium);
            expect(ambiguousVersion.maxConfidence.version, Version.v4_mixinBased);

            final versionWithoutMixin = VersionConfidence(
                v2_legacyBackwardsCompat: Confidence.medium,
                v3_legacyDart2Only: Confidence.medium,
                v4_mixinBased: Confidence.none);
            expect(versionWithoutMixin.maxConfidence.version, Version.v2_legacyBackwardsCompat);
          });
        });
      });

      group('toString returns', () {
        test('all versions', () {
          expect(versionConfidence.toString(), contains('{v2_legacyBackwardsCompat: ${Confidence.low}, v3_legacyDart2Only: ${Confidence.low}, v4_mixinBased: ${Confidence.high}}'));
        });

        test('runtime type', () {
          expect(versionConfidence.toString(), contains('VersionConfidence'));
        });
      });
    });

    group('VersionPair', () {
      test('shouldGenerate will only return true if confidence is higher than medium', () {
        final confidentVersion = VersionConfidence(
            v2_legacyBackwardsCompat: Confidence.low,
            v3_legacyDart2Only: Confidence.low,
            v4_mixinBased: Confidence.high).maxConfidence;
        expect(confidentVersion.shouldGenerate, isTrue);

        final moderatelyConfidentVersion = VersionConfidence.all(Confidence.medium).maxConfidence;
        expect(moderatelyConfidentVersion.shouldGenerate, isFalse);

        final notConfidentVersion = VersionConfidence.none().maxConfidence;
        expect(notConfidentVersion.shouldGenerate, isFalse);
      });
    });
  });
}

enum VersionOptions { v2, v3, v4 }
const boilerplateStrings = {
  VersionOptions.v2: r'''
          @Factory()
          UiFactory<FooProps> Foo = _$Foo;

          @Props()
          class _$FooProps extends UiProps {}

          class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {}

          @State()
          class _$FooState extends UiState with _$FooStateAccessorsMixin {}

          class FooState extends _$FooState with _$FooStateAccessorsMixin {}

          @Component2()
          class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
      ''',
  VersionOptions.v3: r'''
          @Factory()
          UiFactory<FooProps> Foo = _$Foo;

          @Props()
          class _$FooProps extends UiProps {}

          @State()
          class _$FooState extends _$FooState with _$FooStateAccessorsMixin {}

          @Component2()
          class FooComponent extends UiStatefulComponent2<FooProps, FooState>{}
        ''',
  VersionOptions.v4: r'''
          UiFactory<FooProps> Foo = _$Foo;

          mixin FooProps on UiProps {}

          mixin FooState on UiState {}

          class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
        ''',
};
