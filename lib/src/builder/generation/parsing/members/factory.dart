part of '../members.dart';

class BoilerplateFactory extends BoilerplateMember {
  @override
  final TopLevelVariableDeclaration node;

  @override
  SimpleIdentifier get name => node.firstVariable.name;

  TypeAnnotation get propsGenericArg {
    final type = node.variables.type;
    if (type is NamedType && type.typeNameWithoutPrefix == 'UiFactory') {
      final typeArgs = type.typeArguments.arguments;
      if (typeArgs.length == 1) {
        return typeArgs[0];
      }
    }

    return null;
  }

  BoilerplateFactory(
    this.node,
    VersionConfidence declarationConfidence,
  ) : super(declarationConfidence);

  bool get hasFactoryAnnotation => node.hasAnnotationWithName('Factory');

  @override
  void validate(Version version, ErrorCollector errorCollector) {
    switch (version) {
      case Version.v4_mixinBased:
        break;
      case Version.v2_legacyBackwardsCompat:
      case Version.v3_legacyDart2Only:
        if (!hasFactoryAnnotation) {
          errorCollector.addError(
              'Legacy boilerplate factories must be annotated with `@Factory()`.',
              errorCollector.spanFor(node));
        }

        break;
    }

    if (node.variables.variables.length > 1) {
      errorCollector.addError('Multiple factory variables per declaration are not supported.',
          errorCollector.spanFor(node.variables));
    }

    final variable = node.variables.variables.first;
    final factoryName = variable.name.name;
    final expectedInitializer = '$privateSourcePrefix$factoryName';

    if (generatedFactoryReferenceName != expectedInitializer) {
      errorCollector.addError(
          'Should reference generated factory. For example, `UiFactory<...> Foo = _\$Foo;`',
          errorCollector.spanFor(variable));
    } else {
      // When not null, this will be validated as part of the group since
    }
  }

  String get generatedFactoryReferenceName {
    return node.variables.variables.first.initializer?.tryCast<Identifier>()?.nameWithoutPrefix;
  }

//  static bool _isFunctionComponentOrHoc(Expression initializer) {
//    // todo should this instead be
//    return containsFunctionCall(initializer);
//  }
}

//bool containsFunctionCall(AstNode node) {
//  final visitor = _FunctionCallDetector();
//  node.accept(visitor);
//  return visitor.detected;
//}
//class _FunctionCallDetector extends GeneralizingAstVisitor<void> {
//  var detected = false;
//
//  @override
//  void visitInvocationExpression(InvocationExpression node) {
//    detected = true;
//  }
//}
