part of over_react.ui_core;

/// Helper method that returns the `displayName` of the provided React component [factory].
String getNameFromFactory(BuilderOnlyUiFactory factory) => factory().componentFactory.reactClass.displayName;
