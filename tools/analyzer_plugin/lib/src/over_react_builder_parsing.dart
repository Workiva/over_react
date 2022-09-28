// @dart=2.9

/// A library that re-exports over_react's builder code.
///
/// Re-exporting this allows us to limit `src` imports to over_react to a single file,
/// so that they don't become unmanageable and so that we can limit what we import.
///
/// This file also has a language version that opts out of null-safety, since over_react's
/// builder is not null safe.
///
/// As a result, importing it into a file means that we can't use sound null safety in any transitive entrypoints
/// (e.g., the plugin's main entrypoint, test files), resulting in errors when compiling and/or running those files.
///
/// The easiest way to opt out of sound null safety is to add language version comments to each entrypoint.
library over_react_analyzer_plugin.over_react_builder_parsing;

export 'package:over_react/src/builder/parsing.dart';
