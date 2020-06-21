import 'dart:io';

import 'package:analyzer/file_system/file_system.dart' as file_system;
import 'package:analyzer/file_system/physical_file_system.dart' show PhysicalResourceProvider;
import 'package:convert/convert.dart' show hex;
import 'package:crypto/crypto.dart' show md5;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

final logger = Logger('link_plugin');

final resourceProvider = PhysicalResourceProvider.INSTANCE;
final pluginManagerStateFolder = resourceProvider.getStateLocation('.plugin_manager');

main() {
  Logger.root
    ..level = Level.INFO
    ..onRecord.listen(print);

  // Get the package root from the script file location
  final packageRoot = p.canonicalize(p.join(Platform.script.toFilePath(), '..', '..'));
  validatePackageRoot(packageRoot);

  // Same implementation as package:analysis_server/src/plugin/plugin_manager.dart
  final originalPluginFolder = resourceProvider.getFolder(packageRoot);
  final pluginCopyFolder = pluginManagerStateFolder
      .getChildAssumingFolder(_uniqueDirectoryName(originalPluginFolder.path))
      .getChildAssumingFolder(originalPluginFolder.shortName);

  if (pluginCopyFolder.exists) {
    logger.info(pluginCopyFolder.isLink()
        ? 'Deleting existing link to plugin folder, likely created by this script, at ${pluginCopyFolder.userFriendlyPath}'
        : 'Deleting existing copy of plugin folder, created by analysis_server, at ${pluginCopyFolder.userFriendlyPath}');
    pluginCopyFolder.delete();
  } else {
    logger.info("No existing copy of of plugin folder found at ${pluginCopyFolder.userFriendlyPath}"
        "\n\nThis should only happen if you've never run this plugin before, "
        " or if you manually deleted or ${pluginManagerStateFolder.userFriendlyPath}."
        "\n\nIf these situations don't apply, there may be an issue with this script.");
  }

  {
    logger.info('Creating link to current plugin folder');
    final linkTarget = originalPluginFolder;
    final linkLocation = pluginCopyFolder;
    linkLocation.asLink().createSync(linkTarget.path, recursive: true);
    logger.info('Successfully linked: ${linkLocation.userFriendlyPath} -> ${linkTarget.userFriendlyPath}');
  }

  logger.info('Changes to plugin code will now be loaded upon analysis server restart'
      ' without having to delete ${pluginManagerStateFolder.userFriendlyPath} every time.');
}

// From package:analysis_server/src/plugin/plugin_manager.dart
/// Return a hex-encoded MD5 signature of the given file [path].
String _uniqueDirectoryName(String path) {
  var bytes = md5.convert(path.codeUnits).bytes;
  return hex.encode(bytes);
}

extension on file_system.Resource {
  bool isLink() => FileSystemEntity.isLinkSync(path);

  Link asLink() => Link(path);

  String get userFriendlyPath => _userFriendlyPath(path);
}

void validatePackageRoot(String pluginPath) {
  logger.fine('Validating plugin package root ${_userFriendlyPath(pluginPath)}');
  logger.fine('Checking pubspec.yaml');
  final pluginPubspec = File(p.join(pluginPath, 'pubspec.yaml'));
  if (!pluginPubspec.existsSync()) {
    throw Exception('pubspec.yaml does not exist in package root');
  }

  String name;
  try {
    final pubspecContents = pluginPubspec.readAsStringSync();
    final pubspecYaml = loadYaml(pubspecContents);
    name = pubspecYaml['name'];
  } on FileSystemException catch (_) {
    logger.severe('Error reading plugin pubspec.');
    rethrow;
  } catch (_) {
    logger.severe('Error parsing plugin pubspec yaml.');
    rethrow;
  }

  const expectedName = 'over_react_analyzer_plugin';
  if (name != expectedName) {
    throw Exception('Package name was $name; expected $expectedName');
  }

  logger.fine('Plugin package root is valid.');
}

String _userFriendlyPath(String path) {
  var home = Platform.environment['HOME'];
  if (home != null && p.isWithin(home, path)) {
    path = p.join('~', p.relative(path, from: home));
  }

  return path;
}
