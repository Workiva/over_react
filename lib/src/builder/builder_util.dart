import 'dart:mirrors';

import 'package:path/path.dart' as p;
import 'package:build/build.dart' show AssetId;

const outputExtension = '.over_react.g.dart';

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
