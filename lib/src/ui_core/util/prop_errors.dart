library ui_core.prop_errors;

/// Error thrown when a prop, that must be set, is not set.
///
/// Deprecated: Use [PropError].required instead.
@Deprecated('2.0.0')
class RequiredPropError extends Error {
  final String message;

  RequiredPropError(this.message);

  @override
  String toString() => 'RequiredPropError: $message';
}

/// Error thrown when a prop has an invalid value.
///
/// Deprecated: Use [PropError].value instead.
@Deprecated('2.0.0')
class InvalidPropValueError extends Error {
  dynamic value;
  String name;
  String message;

  InvalidPropValueError(this.value, this.name, this.message);

  @override
  String toString() => "InvalidPropValueError: Prop $name set to ${Error.safeToString(value)}: ${this.message}";
}

/// Error thrown when a two props have incompatible values.
///
/// Deprecated: Use [PropError].combination instead.
@Deprecated('2.0.0')
class InvalidPropCombinationError extends Error {
  String prop1;
  String prop2;
  String message;

  InvalidPropCombinationError(this.prop1, this.prop2, this.message);

  @override
  String toString() => "InvalidPropCombinationError: Prop $prop1 and prop $prop2 are set to incompatible values: ${this.message}";
}

/// Error thrown dues to a prop being set incorrectly.
class PropError extends Error {
  static const String defaultPrefix = 'PropError: ';
  static const String requiredPrefix = 'RequiredPropError: ';
  static const String invalidPrefix = 'InvalidPropValueError: ';
  static const String combinationPrefix = 'InvalidPropCombinationError: ';

  final String _messagePrefix;
  final invalidValue;
  final String propName;
  final String prop2Name;
  final message;

  /// Create a new [PropError], with the given [propName] and [message].
  PropError(this.propName, [this.message = ''])
    : invalidValue = null,
      prop2Name = null,
      _messagePrefix = defaultPrefix;

  /// Create a new [PropError] that signifies the given [propName] is required to be set.
  PropError.requried(this.propName, [this.message = ''])
    : invalidValue = null,
      prop2Name = null,
      _messagePrefix = requiredPrefix;

  /// Create a new [PropError] that signifies the given [propName] is set to an [invalidValue].
  PropError.value(this.invalidValue, this.propName, [this.message = ''])
    : prop2Name = null,
      _messagePrefix = invalidPrefix;

  /// Create a new [PropError] that signifies the [propName] and [prop2Name] are in conflict.
  PropError.combination(this.propName, this.prop2Name, [this.message = ''])
    : invalidValue = null,
      _messagePrefix = combinationPrefix;

  @override
  String toString() {
    String explanation;

    if (_messagePrefix == requiredPrefix) {
      explanation = 'Prop $propName is required. ';
    } else if (_messagePrefix == invalidPrefix) {
      explanation = 'Prop $propName set to ${Error.safeToString(invalidValue)}. ';
    } else if (_messagePrefix == combinationPrefix) {
      explanation = 'Prop $propName and prop $prop2Name are set to incompatible values. ';
    } else {
      explanation = 'Prop $propName. ';
    }

    return '$_messagePrefix$explanation$message'.trim();
  }
}
