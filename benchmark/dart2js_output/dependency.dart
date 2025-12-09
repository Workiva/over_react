import 'dart:convert';
import 'dart:io';

const originHeadDepString = 'git:origin/HEAD';
final localPathDepString = jsonEncode({
  'path': Directory.current.path,
});

dynamic parseDependency(String dependency) {
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
