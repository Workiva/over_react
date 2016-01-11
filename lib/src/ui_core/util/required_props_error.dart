library ui_core.required_props_error;

class RequiredPropsError extends Error {
  final String message;

  RequiredPropsError(this.message);

  String toString() => 'RequiredPropsError: ${message}';
}
