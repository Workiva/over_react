// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
  S? tryCast<S extends T>() {
    final value = this;
    return value is S ? value : null;
  }
}

extension IterableUtil<E> on Iterable<E> {
  /// Returns the first element, or `null` if the element is empty.
  E? get firstOrNull => isEmpty ? null : first;

  /// Returns a new lazy iterable with all the elements for which
  /// the [test] predicate returns `false`.
  Iterable<E> whereNot(bool Function(E) test) => where((element) => !test(element));

  /// Returns the first element of type [T], or the result of calling [orElse]
  /// if no such element is found.
  ///
  /// Throws a [StateError] if there is no matching element and [orElse] is omitted.
  T? firstWhereType<T>({T? Function()? orElse}) =>
      whereType<T?>().firstWhere((_) => true, orElse: orElse);
}

extension IterableUtil2<E> on Iterable<E?> {
  /// Returns a new lazy iterable with all elements that are not `null`.
  Iterable<E> whereNotNull() => where((element) => element != null) as Iterable<E>;
}

/// A wrapper around two classes that can be used to pass data when the possible
/// type is not limited to a single class.
///
/// Subset of package:union functionality
class Union<A, B> {
  final A? a;
  final B? b;

  Union.a(this.a)
      : b = null,
        assert(a != null);
  Union.b(this.b)
      : a = null,
        assert(b != null);

  /// Executes a callback based upon which field is set.
  T switchCase<T>(T Function(A) onA, T Function(B) onB) {
    if (a != null) return onA(a!);
    if (b != null) return onB(b!);
    return null;
  }
}

/// Utilities that supplement that functionality of the [Union] class.
///
/// C resolves statically to the closest common ancestor type of A and B.
extension UnionHelper<C> on Union<C, C> {
  /// Access [a] or [b] while allowing the analyzer to provide type inference
  /// when possible.
  C get either => a ?? b!;
}
