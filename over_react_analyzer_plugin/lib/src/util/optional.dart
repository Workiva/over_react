
import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';

T Function(AstNode) parentNodeOfType<T>() {
  T _parentNodeOfType(AstNode node) => node.parent is T ? node.parent as T : null;
  return _parentNodeOfType;
}

class Optional<T> {
  const Optional.of(this.value)
      : this.hasValue = true,
        assert(value != null);
  const Optional.ofNullable(this.value) : this.hasValue = value == null;
  const Optional.empty()
      : this.hasValue = false,
        value = null;

  final T value;
  final bool hasValue;

  Optional<S> ifType<S>() =>
      hasValue && value is S ? Optional.of(value as S) : Optional.empty();

  Optional<S> map<S>(S Function(T) f) =>
      hasValue ? Optional.ofNullable(f(value)) : Optional.empty();

  void ifPresent(void Function(T value) f) {
    if (hasValue) f(value);
  }

  Future<void> ifPresentAsync(FutureOr<void> Function(T value) f) async {
    if (hasValue) await f(value);
  }

  T unwrapOr(T other) => hasValue ? value : other;

  T unwrapOrNull() => unwrapOr(null);

  T unwrapOrElse(T Function() other) => hasValue ? value : other();

  Iterable<T> toIterable() => hasValue ? [value] : [];
}
