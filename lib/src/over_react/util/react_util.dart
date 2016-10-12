part of over_react;

/// Helper method that returns the `displayName` of the provided React component [factory].
String getNameFromFactory(BuilderOnlyUiFactory factory) => factory().componentFactory.reactClass.displayName;
