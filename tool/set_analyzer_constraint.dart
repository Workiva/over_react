import 'dart:io';

final analyzerConstraintPattern =
    RegExp(r'^( +analyzer:\s*).+', multiLine: true);

void main(List<String> args) {
  if (args.length != 1) {
    throw ArgumentError(
        'Expected a single arg for the new analyzer constraint. Args: $args');
  }
  final newAnalyzerConstraint = args.single;

  final pubspec = File('pubspec.yaml');
  final pubspecContents = pubspec.readAsStringSync();

  final matches = analyzerConstraintPattern.allMatches(pubspecContents);
  if (matches.length != 1) {
    throw Exception(
        'Expected 1 analyzer dependency match in ${pubspec.path}, but found ${matches.length}.');
  }

  pubspec.writeAsStringSync(pubspecContents.replaceFirstMapped(
      analyzerConstraintPattern,
      (match) => '${match.group(1)}$newAnalyzerConstraint'));
}
