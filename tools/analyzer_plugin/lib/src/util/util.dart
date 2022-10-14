/// Misc utilities including `tryCast` and [Iterable] extensions
library over_react_analyzer_plugin.src.util;

export 'package:collection/collection.dart' show IterableExtension, IterableNullableExtension;

extension TryCast<T> on T? {
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
  S? tryCast<S extends T>() {
    final value = this;
    return value is S ? value : null;
  }
}

extension IterableUtil<E> on Iterable<E> {
  /// Returns the first element of type [T], or the result of calling [orElse]
  /// if no such element is found.
  ///
  /// Throws a [StateError] if there is no matching element and [orElse] is omitted.
  T firstWhereType<T>({T Function()? orElse}) => whereType<T>().firstWhere((_) => true, orElse: orElse);
}

extension ListUtil<E> on List<E> {
  /// Returns the element at [index], or `null` if the index is greater than the length of this list.
  E? elementAtOrNull(int index) => index < length ? this[index] : null;
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}

class Tuple3<T1, T2, T3> {
  final T1 item1;
  final T2 item2;
  final T3 item3;

  Tuple3(this.item1, this.item2, this.item3);
}

/// A wrapper around two classes that can be used to pass data when the possible
/// type is not limited to a single class.
///
/// Subset of package:union functionality
class Union<A, B> {
  final A? a;
  final B? b;

  Union.a(A this.a) : b = null;

  Union.b(B this.b) : a = null;

  /// Executes a callback based upon which field is set.
  T switchCase<T>(T Function(A) onA, T Function(B) onB) {
    final a = this.a;
    return a != null ? onA(a) : onB(b!);
  }
}

/// Utilities that supplement that functionality of the [Union] class.
///
/// C resolves statically to the closest common ancestor type of A and B.
extension UnionHelper<C> on Union<C, C> {
  /// Access [a] or [b] while allowing the analyzer to provide type inference
  /// when possible.
  C get either => (a ?? b)!;
}
