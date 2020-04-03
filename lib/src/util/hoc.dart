/// Returns a single HOC instance from multiple of the same instance.
///
/// When it is necessary to wrap a `UiComponentFactory` in multiple HOCs,
/// this can be used to declare those HOCs in a flat list, rather than nested with
/// excessive indentation.
///
/// [functions]: A list of HOCs (usually UiFactories) that will be combined into
/// a single HOC with the same function signature.
///
/// __EXAMPLE:__
/// ```dart
/// // Without composeHocs:
/// UiFactory<BigBlockProps> BigBlock = connect<RandomColorStore, BigBlockProps>(
///   // `connect` implementation
/// )(connect<LowLevelStore, BigBlockProps>(
///   // `connect` implementation
/// )(connect<AnotherColorStore, BigBlockProps>(
///   // `connect` implementation
/// )(_$BigBlock)));
///
/// // With composeHocs:
/// UiFactory<BigBlockProps> BigBlock = composeHocs([
///   connect<RandomColorStore, BigBlockProps>(
///     // `connect` implementation
///   ),
///   connect<LowLevelStore, BigBlockProps>(
///     // `connect` implementation
///   ),
///   connect<AnotherColorStore, BigBlockProps>(
///     // `connect` implementation
///   ),
/// ])(_$BigBlock);
/// ```
R Function(A) composeHocs<R, A extends R>(Iterable<R Function(A)> functions) {
  return functions.reduce((a, b) => (result) => a(b(result)));
}
