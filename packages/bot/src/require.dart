library bot.require;

import 'errors.dart';

void require(bool truth, [String message]) {
  if (!truth) {
    throw new Exception(message);
  }
}

void requireArgument(bool truth, String argName, [String message]) {
  _metaRequireArgumentNotNullOrEmpty(argName);
  if (!truth) {
    if (message == null || message.isEmpty) {
      message = 'value was invalid';
    }
    throw new DetailedArgumentError(argName, message);
  }
}

void requireArgumentNotNull(argument, String argName) {
  _metaRequireArgumentNotNullOrEmpty(argName);
  if (argument == null) {
    throw new NullArgumentError(argName);
  }
}

void requireArgumentNotNullOrEmpty(String argument, String argName) {
  _metaRequireArgumentNotNullOrEmpty(argName);
  if (argument == null) {
    throw new NullArgumentError(argName);
  } else if (argument.length == 0) {
    throw new DetailedArgumentError(argName, 'cannot be an empty string');
  }
}

void requireArgumentContainsPattern(Pattern pattern, String argValue,
    String argName) {
  if (pattern == null) {
    throw new InvalidOperationError("That's just sad. No null pattern");
  }
  requireArgumentNotNull(argValue, argName);
  if (!argValue.contains(pattern)) {
    throw new DetailedArgumentError(argName,
        'The value "$argValue" does not contain the pattern "${pattern}"');
  }
}

void _metaRequireArgumentNotNullOrEmpty(String argName) {
  if (argName == null || argName.length == 0) {
    throw new InvalidOperationError("That's just sad. Give me a good argName");
  }
}
