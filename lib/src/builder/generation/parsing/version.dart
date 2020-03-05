import 'package:meta/meta.dart';

import 'members.dart';

@sealed
abstract class Confidence {
  static const none = 0;
  static const veryLow = 1;
  static const medium = 10;
  static const high = 100;
  static const certain = 100000;
}

enum Version {
  v2_legacyBackwardsCompat,
  v3_legacyDart2Only,
  v4_mixinBased,
}

const _versionsInPriorityOrder = [
  Version.v4_mixinBased,
  Version.v2_legacyBackwardsCompat,
  Version.v3_legacyDart2Only,
];

extension VersionExtension on Version {
  bool get isLegacy =>
      this == Version.v2_legacyBackwardsCompat ||
      this == Version.v3_legacyDart2Only;
}

class VersionWithConfidence {
  final Version version;
  final num confidence;

  VersionWithConfidence(this.version, this.confidence);

  bool get shouldGenerate => confidence >= Confidence.medium;
}


VersionWithConfidence resolveVersion(Iterable<BoilerplateMember> members) {
  var totals = VersionConfidence.none();
  for (var member in members) {
    totals += member.versionConfidence;
  }

  return totals.maxConfidence;
}

class VersionConfidence {
  final int v2_legacyBackwardsCompat;
  final int v3_legacyDart2Only;
  final int v4_mixinBased;

  VersionConfidence({
    @required this.v2_legacyBackwardsCompat,
    @required this.v3_legacyDart2Only,
    @required this.v4_mixinBased,
  });

  VersionConfidence.all(int value) : this(
    v2_legacyBackwardsCompat: value,
    v3_legacyDart2Only: value,
    v4_mixinBased: value,
  );

  VersionConfidence.none() : this.all(Confidence.none);


  List<VersionWithConfidence> toList() => [
    VersionWithConfidence(Version.v2_legacyBackwardsCompat, v2_legacyBackwardsCompat),
    VersionWithConfidence(Version.v3_legacyDart2Only, v3_legacyDart2Only),
    VersionWithConfidence(Version.v4_mixinBased, v4_mixinBased),
  ];

  VersionConfidence operator +(VersionConfidence other) {
    return VersionConfidence(
      v2_legacyBackwardsCompat: v2_legacyBackwardsCompat + other.v2_legacyBackwardsCompat,
      v3_legacyDart2Only: v3_legacyDart2Only + other.v3_legacyDart2Only,
      v4_mixinBased: v4_mixinBased + other.v4_mixinBased,
    );
  }

  List<VersionWithConfidence> get _sortedVersions {
    final sortedVersionEntries = toList()
      ..sort((a, b) {
        // Sort highest to lowest for values
        final compareResult = b.confidence.compareTo(a.confidence);
        // For ties, chose the preferred boilerplate.
        if (compareResult == 0) {
          return _versionsInPriorityOrder
              .indexOf(a.version)
              .compareTo(_versionsInPriorityOrder.indexOf(b.version));
        }
        return compareResult;
      });

    return sortedVersionEntries;
  }

  VersionWithConfidence get maxConfidence => _sortedVersions.first;

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


