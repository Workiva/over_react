class Config {
  final Map<String, ConfigSeverity> errors;
  Config(this.errors);
}

enum ConfigSeverity {
  ignore,
  info,
  warning,
  error,
}
