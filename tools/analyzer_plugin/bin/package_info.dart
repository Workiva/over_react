import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

// TODO build a better list of these
const packageNameToRepoName = {
  'cerebral_ui': 'cerebral-ui',
  'copy_ui': 'copy-ui',
  'dart_permissions_editor': 'dart-permissions-editor',
  'tasker': 'tasker-ui',
  'w_sox': 'graph_app',
  'xbrl_module': 'xbrl-module',
};

const reposWithVInTag = {
  'cerebral-ui',
  'doc_plat_client',
};

// To handle packages declared not at the root of the repo.
const customSubdirectoriesByPackageName = {
  'scripting': 'dart',
};

final subpackagePattern = RegExp(r'^doc_plat_client/src/(\w+)/lib/');

ScrapedPackageInfo scrapePackageInfoFromPubspec(Map pubspec) {
  final packageName = pubspec['name'] as String;
  final version = pubspec['version'] as String;
  final isWorkivaHosted = ((pubspec['publish_to'] ?? '') as String).contains('pub.workiva.org');

  return ScrapedPackageInfo(
    packageName,
    version,
    isWorkivaHosted: isWorkivaHosted,
    repoName: packageNameToRepoName[packageName],
  );
}

final _pubspecLockCache = <String, YamlMap>{};
final _pubspecYamlCache = <String, YamlMap>{};

/// Like [scrapePackageInfo] but doesn't choke if the URI is a reference to the root package,
/// which isn't present in pubspec.yaml.
///
/// TODO clean this up; this is a mess
ScrapedPackageInfo? scrapePackageInfoForUriFromContextRoot(Uri uri, String contextRoot) {
  final pubspecLock =
      _pubspecLockCache.putIfAbsent(contextRoot, () => loadPubspecLock(contextRoot));
  return scrapePackageInfo(uri, pubspecLock, onNotFoundPackage: (uri, packageName) {
    final contextRootPubspec =
        _pubspecYamlCache.putIfAbsent(contextRoot, () => loadPubspecYaml(contextRoot));
    final contextRootName = contextRootPubspec['name'] as String?;
    if (packageName == contextRootName) {
      return scrapePackageInfoFromPubspec(contextRootPubspec);
    }
    return null;
  });
}

ScrapedPackageInfo? scrapePackageInfo(
  Uri uri,
  Map? pubspecLock, {
  ScrapedPackageInfo? Function(Uri, String packageName)? onNotFoundPackage,
}) {
  final packageName = getPackageName(uri);
  if (packageName == null) return null;

  final packageInfo = pubspecLock!['packages'][packageName] as Map?;
  if (packageInfo == null) {
    final info = onNotFoundPackage?.call(uri, packageName);
    if (info != null) return info;
    throw Exception('Could not find package info for package "$packageName".'
        ' If this is the root package, consider using `scrapePackageInfoForUriFromContextRoot` instead.');
  }
  final version = packageInfo['version'] as String;
  final isWorkivaHosted = packageInfo['source'] == 'hosted' &&
      ((packageInfo['description'] as Map)['url']?.contains('pub.workiva.org') ?? false) as bool;

  String? subpackageName;
  if (packageName == 'doc_plat_client') {
    final subpackagePathMatch = subpackagePattern.firstMatch(uri.path);
    if (subpackagePathMatch != null) {
      subpackageName = subpackagePathMatch.group(1);
    }
  }

  return ScrapedPackageInfo(
    packageName,
    version,
    isWorkivaHosted: isWorkivaHosted,
    subpackageName: subpackageName,
    repoName: packageNameToRepoName[packageName],
  );
}

class ScrapedPackageInfo {
  final String packageName;
  final String repoName;
  final String version;
  final bool isWorkivaHosted;
  final String? subpackageName;

  ScrapedPackageInfo(this.packageName, this.version,
      {required this.isWorkivaHosted, this.subpackageName, String? repoName})
      : repoName = repoName ?? packageName;

  String get packageAndSubpackageName =>
      subpackageName != null ? '$packageName/$subpackageName' : packageName;
}

String? uriAsLink(ScrapedPackageInfo? info, Uri uri, {int? lineNumber, int? endLineNumber}) {
  if (info == null || !info.isWorkivaHosted) return null;
  assert(getPackageName(uri) == info.packageName);

  final repoName = info.repoName;
  final ref = '${reposWithVInTag.contains(repoName) ? 'v' : ''}${info.version}';
  final sourceBaseUrl = 'https://github.com/Workiva/$repoName/blob/$ref/';

  String path;

  // Attempt to get most DPC links right; this isn't perfect though.
  if (info.packageName == 'doc_plat_client' && info.subpackageName != null) {
    path = uri.path.replaceFirstMapped(subpackagePattern, (match) {
      return 'subpackages/${match.group(1)}/lib/';
    });
  } else {
    // Skip package name
    path = 'lib/' + p.joinAll(uri.pathSegments.skip(1));
  }

  final subdirectory = customSubdirectoriesByPackageName[info.packageName];
  if (subdirectory != null) {
    path = p.join(subdirectory, path);
  }

  final lineNumberSuffix =
      [lineNumber, endLineNumber].where((n) => n != null).map((n) => 'L$n').join('-');

  return sourceBaseUrl + path + (lineNumberSuffix.isEmpty ? '' : '#$lineNumberSuffix');
}

String? getPackageName(Uri uri) {
  if (uri.scheme == 'package') return uri.pathSegments[0];
  return null;
}

String? getLibraryPackageName(LibraryElement library) => getPackageName(library.source.uri);


YamlMap loadPubspecLock(String packageDir) =>
    loadYaml(File(p.join(packageDir, 'pubspec.lock')).readAsStringSync()) as YamlMap;

YamlMap loadPubspecYaml(String packageDir) =>
    loadYaml(File(p.join(packageDir, 'pubspec.yaml')).readAsStringSync()) as YamlMap;

//
// String fileSourcePermalink(pc.PackageConfig config, Uri uri) {
//   final package = config.packageOf(uri);
//   if (package == null) return null;
//
//   final pubspec = p.join(package.root.toFilePath(), 'pubspec.yaml');
//
//   packageConfig.packageOf(unitResult.uri)?.root
// }
