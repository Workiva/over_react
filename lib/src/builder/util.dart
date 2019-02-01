import 'dart:mirrors';

import 'package:analyzer/analyzer.dart';
import 'package:path/path.dart' as p;
import 'package:build/build.dart' show AssetId;
import 'package:source_span/source_span.dart';

const outputExtension = '.over_react.g.dart';
const generatedPrefix = r'_$';
const privatePrefix = r'_';
const publicGeneratedPrefix = r'$';


String getName(Type type) {
  return MirrorSystem.getName(reflectType(type).simpleName);
}

/// Converts [id] to a "package:" URI.
///
/// This will return a schemeless URI if [id] doesn't represent a library in
/// `lib/`.
Uri idToPackageUri(AssetId id) {
  if (!id.path.startsWith('lib/')) {
    return new Uri(path: id.path);
  }

  return new Uri(scheme: 'package',
      path: p.url.join(id.package, id.path.replaceFirst('lib/', '')));
}

/// Returns a string representing a [TypeParameterList], but type bounds removed.
///
/// Example:
///   Input:
///     '<T extends Iterable, U>' //TypeParameterList.toSource()
///   Output:
///     '<T, U>'
String removeBoundsFromTypeParameters(TypeParameterList typeParameters) {
  return typeParameters != null ? (StringBuffer()
    ..write('${typeParameters.leftBracket}')..write(
        typeParameters.typeParameters.map((t) => t.name.name).join(
            ', '))..write('${typeParameters.rightBracket}'))
      .toString()
      : '';
}

/// Returns a [FieldDeclaration] for the meta field on a [ClassDeclaration] if
/// it exists, otherwise returns null.
FieldDeclaration getMetaField(ClassDeclaration cd) {
  bool isPropsOrStateMeta(ClassMember member) {
    if (member is! FieldDeclaration) return false;
    final FieldDeclaration fd = member;
    if (!fd.isStatic) return false;
    if (fd.fields.variables.length > 1) return false;
    if (fd.fields.variables.single.name.name != 'meta') return false;
    return true;
  }
  return cd.members.firstWhere(isPropsOrStateMeta, orElse: () => null);
}

String messageWithSpan(String message, {SourceSpan span}) {
  final spanMsg = span != null ? '\nSource: ${span.highlight()}' : '';
  return '$message$spanMsg';
}

