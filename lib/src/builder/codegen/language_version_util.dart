// @dart=2.11
import 'package:analyzer/dart/ast/token.dart' show LanguageVersionToken;
import 'package:package_config/package_config.dart' show LanguageVersion;

bool _languageVersionSupportsNullSafety(int major, int minor) =>
    major > 2 || (major == 2 && minor >= 12);

extension LanguageVersionToken$NullSafety on LanguageVersionToken {
  bool get supportsNullSafety => _languageVersionSupportsNullSafety(major, minor);
}

extension LanguageVersion$NullSafety on LanguageVersion {
  bool get supportsNullSafety => _languageVersionSupportsNullSafety(major, minor);
}
