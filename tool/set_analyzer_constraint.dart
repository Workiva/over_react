import 'dart:io';

final analyzerConstraintPattern = RegExp(r'^( +analyzer:\s*).+', multiLine: true);

/// Dev dependencies whose own analyzer constraints are lower than ours, and which
/// would otherwise prevent `pub get` from resolving the analyzer version under test.
/// None of them are needed by the analysis/build/test steps that run afterwards.
const _devDepsToRemove = ['dart_dev', 'dependency_validator', 'build_web_compilers'];

void main(List<String> args) {
  if (args.length != 1) {
    throw ArgumentError('Expected a single arg for the new analyzer constraint. Args: $args');
  }
  final newAnalyzerConstraint = args.single;

  final pubspec = File('pubspec.yaml');
  var contents = pubspec.readAsStringSync();

  final matches = analyzerConstraintPattern.allMatches(contents);
  if (matches.length != 1) {
    throw Exception(
        'Expected 1 analyzer dependency match in ${pubspec.path}, but found ${matches.length}.');
  }

  contents = contents.replaceFirstMapped(
      analyzerConstraintPattern, (match) => '${match.group(1)}$newAnalyzerConstraint');

  for (final devDep in _devDepsToRemove) {
    // Also consumes any comment lines directly above the dependency.
    final pattern = RegExp('^(?: *#.*\n)* +$devDep:.*\n', multiLine: true);
    final devDepMatches = pattern.allMatches(contents);
    if (devDepMatches.length != 1) {
      throw Exception('Expected 1 $devDep dependency match in ${pubspec.path},'
          ' but found ${devDepMatches.length}.');
    }
    contents = contents.replaceFirst(pattern, '');
  }

  pubspec.writeAsStringSync(contents);
}
