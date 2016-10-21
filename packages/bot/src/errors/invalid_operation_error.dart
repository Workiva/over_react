part of bot.errors;

class InvalidOperationError implements Exception {
  final String message;

  const InvalidOperationError([this.message = ""]);
}
