library ui_core.constants;

/// A named constant with a helpful string representation.
abstract class DebugFriendlyConstant {
  /// The name of this constant, for debugging purposes only.
  final String _name;

  const DebugFriendlyConstant(this._name);

  /// A helpful description of this constant, used in [toString].
  String get debugDescription;

  @override
  String toString() {
    var string = '$runtimeType.$_name';

    var debugDescription = this.debugDescription;
    if (debugDescription != null) {
      string = '$string ($debugDescription)';
    }

    return string;
  }
}

/// A named constant with a helpful string representation
/// that contains a CSS class name value.
abstract class ClassNameConstant extends DebugFriendlyConstant {
  /// The CSS class name value associated with this constant.
  final String className;

  const ClassNameConstant(String name, this.className) : super(name);

  @override
  String get debugDescription => 'className: $className';
}
