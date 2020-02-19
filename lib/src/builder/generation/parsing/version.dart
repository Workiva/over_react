
import 'package:meta/meta.dart';

import 'members.dart';

@sealed
abstract class Confidence {
  static const none = 0;
  static const veryLow = 1;
//  static const low = 5;
  static const medium = 10;
  static const high = 20;
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

List<BoilerplateVersion> resolveVersions(Iterable<BoilerplateMember> members) {
  final totals = <BoilerplateVersion, int>{};
  for (var member in members) {
    member.versionConfidence.forEach((key, value) {
      totals[key] = (totals[key] ?? 0) + value;
    });
  }

  final versions = totals.entries.where((entry) => entry.value != 0).toList()
    ..sort((a, b) {
      final compareResult = a.value.compareTo(b.value);
      // For ties, chose the preferred boilerplate.
      if (compareResult == 0) {
        return boilerplateVersionPriority.indexOf(a.key).compareTo(boilerplateVersionPriority.indexOf(b.key));
      }
      return compareResult;
    });

  return versions.map((entry) => entry.key).toList();
}
