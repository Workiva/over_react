/// Misc utilities including `tryCast` and [Iterable] extensions
library over_react_analyzer_plugin.src.util;

export 'package:collection/collection.dart' show IterableExtension, IterableNullableExtension;

extension TryCast<T> on T {
  /// Returns this casted as [S] if it is an instance of that type, or `null` otherwise.
  ///
  /// Useful for simplifying is-checks, especially on nested objects.
  ///
  /// Example:
  ///
  ///     // Without tryCast:
  ///
  ///     Block block;
  ///     if (node.body is BlockFunctionBody) {
  ///       // Cast necessary here since `.body` can't undergo type promotion.
  ///       block = (node.body as BlockFunctionBody).block;
  ///     }
  ///
  ///     // With tryCast
  ///     final block = node.body?.tryCast<BlockFunctionBody>()?.block;
  ///
  S/*?*/ tryCast<S extends T>() {
    final value = this;
    return value is S ? value : null;
  }
}

extension IterableUtil<E> on Iterable<E> {
  /// Returns the first element of type [T], or the result of calling [orElse]
  /// if no such element is found.
  ///
  /// Throws a [StateError] if there is no matching element and [orElse] is omitted.
  T/*!*/ firstWhereType<T>({T/*!*/ Function() orElse}) =>
      whereType<T>().firstWhere((_) => true, orElse: orElse);
}

