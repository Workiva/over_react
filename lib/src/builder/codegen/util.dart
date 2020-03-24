import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:source_span/source_span.dart';

import '../parsing.dart';
import 'names.dart';

class AccessorType {
  final bool isProps;
  final bool isAbstract;
  final bool isMixin;
  // ignore: avoid_positional_boolean_parameters
  const AccessorType(this.isProps, this.isAbstract, this.isMixin);

  static const AccessorType props = AccessorType(true, false, false);
  static const AccessorType state = AccessorType(false, false, false);
  static const AccessorType abstractProps = AccessorType(true, true, false);
  static const AccessorType abstractState = AccessorType(false, true, false);
  static const AccessorType propsMixin = AccessorType(true, false, true);
  static const AccessorType stateMixin = AccessorType(false, false, true);
}

abstract class Generator {
  SourceFile sourceFile;
  StringBuffer outputContentsBuffer;
  Logger logger;

  @protected
  Version get version;

  @protected
  String internalGeneratedMemberDeprecationLine({String additionalMessageStringLiteral = ''}) {
    final string = version.isLegacy
        ? ''
        : '@Deprecated('
            "'This API is for use only within generated code.'"
            "' Do not reference it in your code, as it may change at any time.'"
            '$additionalMessageStringLiteral'
            ')\n';

    assert(string.isEmpty || string.endsWith('\n'),
        'code that consumes this relies on there being a trailing newline if it is non-empty');
    return string;
  }

  void generate();
}

String getAccessorKeyNamespace(TypedMapNames names, annotations.TypedMap meta) {
  // Default to the name of the class followed by a period.
  final defaultNamespace = '${names.publicName}.';
  // Allow the consumer to specify a custom namespace that trumps the default.
  final specifiedKeyNamespace = meta?.keyNamespace;

  return specifiedKeyNamespace ?? defaultNamespace;
}

String generatedMixinWarningCommentLine(TypedMapNames mixinNames, {@required bool isProps}) {
  final value = '// If this generated mixin is undefined, it\'s likely because'
      ' ${mixinNames.consumerName} is not a valid `mixin`-based ${isProps ? 'props' : 'state'} mixin,'
      ' or because it is but the generated mixin was not exported.'
      ' Check the declaration of ${mixinNames.consumerName}.\n';

  assert(value.endsWith('\n'));

  return value;
}
