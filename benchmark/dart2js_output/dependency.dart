import 'dart:convert';
import 'dart:io';

const originHeadDepString = 'git:origin/HEAD';
final localPathDepString = jsonEncode({
  'path': Directory.current.path,
});

/// Parses a string representation of an `over_react` [dependency] from a command-line arg.
///
/// Supports either
/// - a JSON format, equivalent to the YAML-parsed value of `dependencies`.`over_react` in a pubspec.yaml
/// - a `git:<ref>` shorthand
dynamic parseOverReactDependency(String dependency) {
  final gitShorthandMatch = RegExp(r'^git:(.+)$').matchAsPrefix(dependency);
  if (gitShorthandMatch != null) {
    return {
      'git': {
        'url': Directory.current.uri.toString(),
        'ref': gitShorthandMatch.group(1)!,
      }
    };
  }
  try {
    return jsonDecode(dependency);
  } catch (e) {
    throw ArgumentError.value(
        dependency, 'dependency', 'must be a valid JSON String or a git:<ref> shorthand');
  }
}
