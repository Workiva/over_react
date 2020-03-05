import 'dart:math' as math;
import 'package:meta/meta.dart';

import 'members.dart';
import 'util.dart';

@sealed
abstract class Confidence {
  static const none = 0;
  static const veryLow = 1;

//  static const low = 5;
  static const medium = 10;
  static const high = 100;
  static const certain = 100000;
}

extension VersionConfidenceMap on Map<BoilerplateVersion, int> {
  Map<BoilerplateVersion, int> operator +(Map<BoilerplateVersion, int> other) {
    final keys = this.keys.toSet()..addAll(other.keys);
    return {
      for (var key in keys) key: (this[key] ?? 0) + (other[key] ?? 0),
    };
  }

  List<MapEntry<BoilerplateVersion, int>> get _sortedVersions {
    final sortedVersionEntries = entries.where((entry) => entry.value != 0).toList()
      ..sort((a, b) {
        // Sort highest to lowest for values
        final compareResult = b.value.compareTo(a.value);
        // For ties, chose the preferred boilerplate.
        if (compareResult == 0) {
          return boilerplateVersionPriority
              .indexOf(a.key)
              .compareTo(boilerplateVersionPriority.indexOf(b.key));
        }
        return compareResult;
      });

    return sortedVersionEntries;
  }

  VersionWithConfidence get maxConfidence {
    final best = _sortedVersions.firstOrNull;
    return VersionWithConfidence(
      // This value shouldn't matter if the confidence is 0; it just needs to be non-null.
      best?.key ?? boilerplateVersionPriority.first,
      best.value ?? 0,
    );
  }
}

const boilerplateVersionPriority = [
  BoilerplateVersion.v4_mixinBased,
  BoilerplateVersion.v2_legacyBackwardsCompat,
  BoilerplateVersion.v3_legacyDart2Only,
];

enum BoilerplateVersion {
  v2_legacyBackwardsCompat,
  v3_legacyDart2Only,
  v4_mixinBased,
}

class VersionWithConfidence {
  final BoilerplateVersion version;
  final num confidence;

  VersionWithConfidence(this.version, this.confidence);

  bool get shouldGenerate => confidence >= Confidence.medium;
}

extension BoilerplateVersionExtension on BoilerplateVersion {
  bool get isLegacy =>
      this == BoilerplateVersion.v2_legacyBackwardsCompat ||
      this == BoilerplateVersion.v3_legacyDart2Only;
}

VersionWithConfidence resolveVersion(Iterable<BoilerplateMember> members) {
  var totals = <BoilerplateVersion, int>{};
  for (var member in members) {
    totals += member.versionConfidence;
  }

  return totals.maxConfidence;
}



