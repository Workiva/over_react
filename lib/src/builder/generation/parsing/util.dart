extension TryCast<T> on T {
  S tryCast<S extends T>() => this is S ? this : null;
  S tryCastUnrelatedType<S>() => this is S ? (this as S) : null;
}

extension IterableUtil<E> on Iterable<E> {
  E get firstOrNull => this.isEmpty ? null : this.first;
  Iterable<E> whereNotNull() => this.where((element) => element != null);
}

// Subset of package:union functionality
class Union<A, B> {
  final A a;
  final B b;

  Union.a(this.a) : b = null;
  Union.b(this.b) : a = null;
}

// C resolves statically to the closest common ancestor type of A and B.
extension UnionHelper<C> on Union<C, C> {
  C get either => a ?? b;
}
