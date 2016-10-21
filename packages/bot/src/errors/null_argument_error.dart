part of bot.errors;

class NullArgumentError extends DetailedArgumentError {
  NullArgumentError(String argument) : super(argument, "cannot be null");
}
