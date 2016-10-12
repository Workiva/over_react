library over_react.react_util;

import 'package:over_react/src/component_declaration/component_base.dart';

/// Helper method that returns the `displayName` of the provided React component [factory].
String getNameFromFactory(BuilderOnlyUiFactory factory) => factory().componentFactory.reactClass.displayName;
