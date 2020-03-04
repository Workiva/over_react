@TestOn('vm')
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:over_react/src/builder/generation/parsing.dart';
import 'package:test/test.dart';

import 'package:over_react/src/builder/generation/parsing/members.dart';

main() {
  Iterable<BoilerplateMember> members;

  Iterable<BoilerplateMember> getBoilerplateMembers(VersionOptions version) {
    final unit = parseString(content: boilerplateStrings[version]).unit;

    return BoilerplateMembers.detect(unit).allMembers;
  }

  tearDown(() {
    members = null;
  });

  group('resolveVersions', () {
    Iterable<BoilerplateVersion> versions;

    tearDown(() {
      versions = null;
    });

    group('detects basic cases correctly -', () {
      test('v2_legacyBackwordsCompat', () {
        members = getBoilerplateMembers(VersionOptions.v2);
        versions = resolveVersions(members);

        expect(versions.first, BoilerplateVersion.v2_legacyBackwardsCompat);
        expect(
            versions,
            containsAllInOrder([
              BoilerplateVersion.v2_legacyBackwardsCompat,
              BoilerplateVersion.v3_legacyDart2Only,
              BoilerplateVersion.v4_mixinBased,
              BoilerplateVersion.noGenerate
            ]));
      });

      test('v3_legacyDart2Only', () {
        members = getBoilerplateMembers(VersionOptions.v3);
        versions = resolveVersions(members);

        expect(versions.first, BoilerplateVersion.v3_legacyDart2Only);
        expect(
            versions,
            containsAllInOrder([
              BoilerplateVersion.v3_legacyDart2Only,
              BoilerplateVersion.v2_legacyBackwardsCompat,
              BoilerplateVersion.v4_mixinBased,
              BoilerplateVersion.noGenerate
            ]));
      });

      // TODO uncomment test when mixin parser is implemented
      test('v4_mixinBased', () {
//        members = getBoilerplateMembers(VersionOptions.v4);
//        versions = resolveVersions(members);
//
//        expect(versions.first, BoilerplateVersion.v4_mixinBased);
//        expect(versions, containsAllInOrder([
//            BoilerplateVersion.v4_mixinBased,
//            BoilerplateVersion.v3_legacyDart2Only,
//            BoilerplateVersion.v2_legacyBackwardsCompat,
//            BoilerplateVersion.noGenerate
//          ]));
      });

      test('noGenerate', () {
        members = getBoilerplateMembers(VersionOptions.v5);
        versions = resolveVersions(members);

        expect(versions.first, BoilerplateVersion.noGenerate);
        expect(versions, containsAllInOrder([BoilerplateVersion.noGenerate]));
      });
    });
  });

  group('resolveVersion', () {
    group('returns the correct version -', () {
      test('v2_legacyBackwordsCompat', () {
        members = getBoilerplateMembers(VersionOptions.v2);
        expect(resolveVersion(members), BoilerplateVersion.v2_legacyBackwardsCompat);
      });

      test('v3_legacyDart2Only', () {
        members = getBoilerplateMembers(VersionOptions.v3);

        expect(resolveVersion(members), BoilerplateVersion.v3_legacyDart2Only);
      });

      // TODO uncomment test when mixin parser is implemented
      test('v4_mixinBased', () {
//        members = getBoilerplateMembers(VersionOptions.v4);
//        expect(resolveVersions(members), BoilerplateVersion.v4_mixinBased);
      });

      test('noGenerate', () {
        members = getBoilerplateMembers(VersionOptions.v5);
        expect(resolveVersion(members), BoilerplateVersion.noGenerate);
      });
    });
  });

  group('BoilerplateVersion', () {
    group('isLegacy', () {
      test('detects legacy instances correctly', () {
        final legacy1Members = getBoilerplateMembers(VersionOptions.v2);
        final legacy2Members = getBoilerplateMembers(VersionOptions.v3);

        expect(resolveVersion(legacy1Members).isLegacy, isTrue);
        expect(resolveVersion(legacy2Members).isLegacy, isTrue);
      });

      test('detects non-legacy instances correctly', () {
        // TODO uncomment new boilerplate members
//        final legacy2Members = getBoilerplateMembers(VersionOptions.v3);
        final legacy1Members = getBoilerplateMembers(VersionOptions.v5);

        expect(resolveVersion(legacy1Members).isLegacy, isFalse);
      });
    });
  });
}

enum VersionOptions { v2, v3, v4, v5 }
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

          @Component()
          class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
      ''',
  VersionOptions.v3: r'''
          @Factory()
          UiFactory<FooProps> Foo = _$Foo;

          @Props()
          class _$FooProps extends UiProps {}

          @State()
          class _$FooState extends _$FooState with _$FooStateAccessorsMixin {}

          @Component()
          class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
        ''',
  VersionOptions.v4: r'''
          UiFactory<FooProps> Foo = _$Foo;

          mixin FooProps on UiProps {}

          mixin FooState on UiState {}

          class FooComponent extends UiStatefulComponent<FooProps, FooState>{}
        ''',
  VersionOptions.v5: r'''    
          class FooComponent extends react.Component {}
        ''',
};
