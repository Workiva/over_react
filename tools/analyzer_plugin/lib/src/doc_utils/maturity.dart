// Stolen directly from `package:analyzer/src/lint/linter.dart`
class Maturity implements Comparable<Maturity> {
  static const Maturity stable = Maturity._('stable', ordinal: 0);
  static const Maturity experimental = Maturity._('experimental', ordinal: 1);
  static const Maturity deprecated = Maturity._('deprecated', ordinal: 2);

  final String name;
  final int ordinal;

  factory Maturity(String name, {int ordinal}) {
    switch (name.toLowerCase()) {
      case 'stable':
        return stable;
      case 'experimental':
        return experimental;
      case 'deprecated':
        return deprecated;
      default:
        return Maturity._(name, ordinal: ordinal);
    }
  }

  const Maturity._(this.name, {this.ordinal});

  @override
  int compareTo(Maturity other) => ordinal - other.ordinal;

  @override
  String toString() => name;

  /// A list containing all of the enum values that are defined.
  static const List<Maturity> VALUES = <Maturity>[
    stable,
    experimental,
    deprecated,
  ];
}
