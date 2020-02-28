import 'package:meta/meta.dart';

import 'members.dart';

@sealed
abstract class Confidence {
  static const none = 0;
  static const veryLow = 1;
//  static const low = 5;
  static const medium = 10;
  static const high = 20;
  static const certain = 100000;
}

const boilerplateVersionPriority = [
  BoilerplateVersion.v4_mixinBased,
  BoilerplateVersion.v2_legacyBackwardsCompat,
  BoilerplateVersion.v3_legacyDart2Only,
  BoilerplateVersion.noGenerate,
];

enum BoilerplateVersion {
  v2_legacyBackwardsCompat,
  v3_legacyDart2Only,
  v4_mixinBased,
  noGenerate,
}

extension BoilerplateVersionExtension on BoilerplateVersion {
  bool get isLegacy => this == BoilerplateVersion.v2_legacyBackwardsCompat || this == BoilerplateVersion.v3_legacyDart2Only;
}

BoilerplateVersion resolveVersion(Iterable<BoilerplateMember> members) {
  return resolveVersions(members).first;
}

List<BoilerplateVersion> resolveVersions(Iterable<BoilerplateMember> members) {
  final totals = <BoilerplateVersion, int>{};
  for (var member in members) {
    member.versionConfidence.forEach((key, value) {
      totals[key] = (totals[key] ?? 0) + value;
    });
  }

  final sortedVersionEntries = totals.entries.where((entry) => entry.value != 0).toList()
    ..sort((a, b) {
      // Sort highest to lowest for values
      final compareResult = b.value.compareTo(a.value);
      // For ties, chose the preferred boilerplate.
      if (compareResult == 0) {
        return boilerplateVersionPriority.indexOf(a.key).compareTo(boilerplateVersionPriority.indexOf(b.key));
      }
      return compareResult;
    });

  final versions = sortedVersionEntries.map((entry) => entry.key).toList();
  return versions.isNotEmpty ? versions : [BoilerplateVersion.noGenerate];
}
