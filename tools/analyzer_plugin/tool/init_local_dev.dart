import 'dart:io';

import 'package:analyzer/file_system/file_system.dart' as file_system;
import 'package:analyzer/file_system/physical_file_system.dart' show PhysicalResourceProvider;
import 'package:convert/convert.dart' show hex;
import 'package:crypto/crypto.dart' show md5;
import 'package:io/ansi.dart' as ansi;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'logging.dart';

final logger = Logger('init_local_dev');

final resourceProvider = PhysicalResourceProvider.INSTANCE;
final pluginManagerStateFolder = resourceProvider.getStateLocation('.plugin_manager')!;

/// Normally, the Dart Analysis Server does a one-time copy of plugin code into the Dart Analysis Server state folder
/// (usually `~/.dartServer/.plugin_manager`), and never updates for plugins derived from path dependencies (TODO make dart-lang issue for this).
///
/// This means, normally, ___any changes you make to the plugin will not be reflected___.
///
/// This script sets up a symlink to point to the original plugin directory (replacing any copy if it exists),
/// so that changes are always reflected.
void main(List<String> args) {
  initLogging(verbose: args.contains('--verbose'));

  // Get the package root from the script file location
  final packageRoot = p.canonicalize(p.join(Platform.script.toFilePath(), '..', '..'));
  validatePackageRoot(packageRoot);

  // Same implementation as package:analysis_server/src/plugin/plugin_manager.dart
  final originalPluginFolder = resourceProvider.getFolder(packageRoot);
  final pluginCopyFolder = pluginManagerStateFolder
      .getChildAssumingFolder(_uniqueDirectoryName(originalPluginFolder.path))
      .getChildAssumingFolder(originalPluginFolder.shortName);

  logger.info('Creating link to current plugin folder...');
  if (pluginCopyFolder.exists) {
    logger.info(pluginCopyFolder.isLink()
        ? 'Deleting existing link to plugin folder, likely created by this script, at ${pluginCopyFolder.formatPath()}'
        : 'Deleting existing copy of plugin folder, created by analysis_server, at ${pluginCopyFolder.formatPath()}');
    pluginCopyFolder.delete();
  } else {
    logger.warning("\nNo existing copy of of plugin folder found at ${pluginCopyFolder.formatPath()}."
        "\n\nThis should only happen if:"
        "\n  1. You've never run the plugin declared in this folder before"
        "\n  2. You manually deleted ${pluginManagerStateFolder.formatPath()} or one of its ancestor directories at some point"
        "\n\nIf these situations don't apply, there\'s likely an issue with this script. Please open an issue and tag greglittlefield-wf.\n");
  }

  {
    final linkTarget = originalPluginFolder;
    final linkLocation = pluginCopyFolder;
    linkLocation.asLink().createSync(linkTarget.path, recursive: true);
    logger.info('Link created: ${linkLocation.formatPath()} -> ${linkTarget.formatPath()}\n');
  }

  logger.info(ansi.green.wrap('Successfully linked!'
      '\nChanges to plugin code will now be loaded upon analysis server restart'
      ' without having to delete ${pluginManagerStateFolder.formatPath()} every time.'));
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

  String formatPath() => path.formatPath();
}

extension on String {
  static String _userFriendlyPath(String path) {
    var home = Platform.environment['HOME'];
    if (home != null && p.isWithin(home, path)) {
      path = p.join('~', p.relative(path, from: home));
    }

    return path;
  }

  String formatPath() => '`${_userFriendlyPath(this)}`';
}

void validatePackageRoot(String pluginPath) {
  logger.fine('Validating plugin package root ${pluginPath.formatPath()}...');
  logger.fine('Checking pubspec.yaml...');
  final pluginPubspec = File(p.join(pluginPath, 'pubspec.yaml'));
  if (!pluginPubspec.existsSync()) {
    throw Exception('pubspec.yaml does not exist in package root');
  }

  String name;
  try {
    final pubspecContents = pluginPubspec.readAsStringSync();
    final pubspecYaml = loadYaml(pubspecContents) as Map;
    name = pubspecYaml['name'] as String;
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

  logger.fine('Plugin package root is valid.\n');
}
