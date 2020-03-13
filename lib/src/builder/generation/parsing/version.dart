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

import 'package:meta/meta.dart';

import 'members.dart';

/// The confidence levels related to boilerplate [Version]s.
///
/// As the builder detects members, it generates a confidence based on the
/// implementation details of the member. This confidence score is then averaged
/// over all of the grouped members (factory, props, state, component, etc).
///
/// Related: [resolveVersion]
@sealed
abstract class Confidence {
  static const none = 0;
  static const low = 1;
  static const medium = 10;
  static const high = 100;
  static const certain = 100000;
}

/// The current versions of the boilerplate that the builder detects.
///
/// Related: [resolveVersion]
enum Version {
  v2_legacyBackwardsCompat,
  v3_legacyDart2Only,
  v4_mixinBased,
}

/// Priority of the possible boilerplates.
///
/// In the event that two different [Version]s have the same confidence score,
/// version of high priority wins out.
///
/// The length of this iterable should match the length of values in [Version].
const _versionsInPriorityOrder = [
  Version.v4_mixinBased,
  Version.v2_legacyBackwardsCompat,
  Version.v3_legacyDart2Only,
];

/// Utils to add capabilities to the [Version] enum.
extension VersionExtension on Version {
  /// Validates whether or not the current version is one grouped in the "Legacy" category.
  ///
  /// Because each boilerplate member and declaration has a version property,
  /// this getter provides a declarative way to detect if that object is legacy.
  bool get isLegacy =>
      this == Version.v2_legacyBackwardsCompat || this == Version.v3_legacyDart2Only;
}

/// An encapsulation of the data useful when evaluating a member version.
///
/// This can also be used when the builder is making generation decisions.
class VersionConfidencePair {
  /// The evaluated version for a group of members.
  ///
  /// __Note:__ this is not always the version of an individual member, but rather
  /// can be the version evaluation that is used to generate the class implementations.
  /// This is the case then the object is being returned from [resolveVersion].
  final Version version;

  /// The numerical representation of version confidence.
  ///
  /// When being returned from [resolveVersion], this is the total confidence
  /// for all included members summed and then averaged.
  final num confidence;

  VersionConfidencePair(this.version, this.confidence);

  /// Whether or not there is enough confidence to generate an implementation.
  ///
  /// Based on the boilerplate members cumulatively, there may not be enough data
  /// to signify that generation is necessary. This is the case when the [confidence]
  /// (the average confidence score for all members) is not above [Confidence.medium].
  ///
  /// __Note:__ Since the purpose of this getter is specific to the generator, it should
  /// not be trusted unless this is initialized as the return value for [resolveVersion].
  bool get shouldGenerate => confidence > Confidence.medium;
}

/// Returns a confidence pair with
/// - a [VersionConfidencePair.version] equal to the highest-confidence version among all [members]
/// - a [VersionConfidencePair.confidence] equal to the average of all confidences for that version
VersionConfidencePair resolveVersion(Iterable<BoilerplateMember> members) {
  var totals = VersionConfidence.none();
  for (var member in members) {
    totals += member.versionConfidence;
  }
  final max = totals.maxConfidence;

  return VersionConfidencePair(max.version, max.confidence / members.length);
}

/// The class that monitors the different version possibilities and the confidence
/// for each version.
///
/// When resolving the version, this data is used to aggregate specific version
/// confidence while keeping all the data in a single class.
class VersionConfidence {
  // The confidence for each specific version
  final int v2_legacyBackwardsCompat;
  final int v3_legacyDart2Only;
  final int v4_mixinBased;

  /// The highest confidence within the class.
  ///
  /// In the case that two confidences are the same, the higher priority (as
  /// determined by [_versionsInPriorityOrder]) wins out.
  VersionConfidencePair get maxConfidence => _sortedVersions.first;

  VersionConfidence({
    @required this.v2_legacyBackwardsCompat,
    @required this.v3_legacyDart2Only,
    @required this.v4_mixinBased,
  });

  /// Constructor to set all confidence values to the same thing
  VersionConfidence.all(int value)
      : this(
          v2_legacyBackwardsCompat: value,
          v3_legacyDart2Only: value,
          v4_mixinBased: value,
        );

  /// Constructor to initialize the class with no data.
  ///
  /// This is useful to create a placeholder instance as the [+] operator
  /// returns a new instance.
  VersionConfidence.none() : this.all(Confidence.none);

  /// Creates a [List] that holds the versions and their corresponding confidence.
  List<VersionConfidencePair> toList() => [
        VersionConfidencePair(Version.v2_legacyBackwardsCompat, v2_legacyBackwardsCompat),
        VersionConfidencePair(Version.v3_legacyDart2Only, v3_legacyDart2Only),
        VersionConfidencePair(Version.v4_mixinBased, v4_mixinBased),
      ];

  /// Adds all versions in the class to another set of versions from a different [VersionConfidence]
  /// object.
  VersionConfidence operator +(VersionConfidence other) {
    return VersionConfidence(
      v2_legacyBackwardsCompat: v2_legacyBackwardsCompat + other.v2_legacyBackwardsCompat,
      v3_legacyDart2Only: v3_legacyDart2Only + other.v3_legacyDart2Only,
      v4_mixinBased: v4_mixinBased + other.v4_mixinBased,
    );
  }

  List<VersionConfidencePair> get _sortedVersions {
    final sortedVersionEntries = toList()
      ..sort((a, b) {
        // Sort highest to lowest for values
        final compareResult = b.confidence.compareTo(a.confidence);
        // For ties, choose the preferred boilerplate.
        if (compareResult == 0) {
          return _versionsInPriorityOrder
              .indexOf(a.version)
              .compareTo(_versionsInPriorityOrder.indexOf(b.version));
        }
        return compareResult;
      });

    return sortedVersionEntries;
  }

  @override
  String toString() {
    final confidenceMap = {
      'v2_legacyBackwardsCompat': v2_legacyBackwardsCompat,
      'v3_legacyDart2Only': v3_legacyDart2Only,
      'v4_mixinBased': v4_mixinBased,
    };

    return '${runtimeType.toString()}; confidence:$confidenceMap';
  }
}
