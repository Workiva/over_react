import 'package:logging/logging.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:source_span/source_span.dart';

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

  void generate();
}


String getAccessorKeyNamespace(TypedMapNames names, annotations.TypedMap meta) {
  // Default to the name of the class followed by a period.
  final defaultNamespace = '${names.publicName}.';
  // Allow the consumer to specify a custom namespace that trumps the default.
  final specifiedKeyNamespace = meta?.keyNamespace;

  return specifiedKeyNamespace ?? defaultNamespace;
}
