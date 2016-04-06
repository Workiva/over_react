library ui_core.prop_errors;

/// Error thrown when a prop, that must be set, is not set.
class RequiredPropError extends Error {
  final String message;

  RequiredPropError(this.message);

  @override
  String toString() => 'RequiredPropError: $message';
}

/// Error thrown when a prop has an invalid value.
class InvalidPropValueError extends Error {
  dynamic value;
  String name;
  String message;

  InvalidPropValueError(this.value, this.name, this.message);

  @override
  String toString() => "InvalidPropValueError: Prop $name set to ${Error.safeToString(value)}: ${this.message}";
}

/// Error thrown when a two props have incompatible values.
class InvalidPropCombinationError extends Error {
  String prop1;
  String prop2;
  String message;

  InvalidPropCombinationError(this.prop1, this.prop2, this.message);

  @override
  String toString() => "InvalidPropCombinationError: Prop $prop1 and prop $prop2 are set to incompatible values: ${this.message}";
}
