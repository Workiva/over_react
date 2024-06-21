/// A library that re-exports over_react's builder code.
///
/// Re-exporting this allows us to limit `src` imports to over_react to a single file,
/// so that they don't become unmanageable and so that we can limit what we import.
library over_react_analyzer_plugin.over_react_builder_parsing;

export 'package:over_react/src/builder/parsing.dart';
