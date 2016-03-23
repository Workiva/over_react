library ui_core.prop_errors;

class RequiredPropsError extends Error {
  final String message;

  RequiredPropsError(this.message);

  String toString() => 'RequiredPropsError: $message';
}

class InvalidPropValueError extends Error {
  dynamic value;
  String name;
  String message;

  InvalidPropValueError(this.value, this.name, this.message);

  String toString() => "InvalidPropValueError: Prop $name set to ${Error.safeToString(value)}: ${this.message}";
}
