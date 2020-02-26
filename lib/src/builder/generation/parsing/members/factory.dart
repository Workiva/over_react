part of '../members.dart';

class BoilerplateFactory extends BoilerplateMember {
  @override
  final TopLevelVariableDeclaration node;

  SimpleIdentifier get name => node.firstVariable.name;

  BoilerplateFactory(this.node, int declarationConfidence) : super(declarationConfidence);

  @override
  Map<BoilerplateVersion, int> get versionConfidence => {
    BoilerplateVersion.v2_legacyBackwardsCompat: hasFactoryAnnotation ? Confidence.medium : Confidence.veryLow,
    BoilerplateVersion.v3_legacyDart2Only: hasFactoryAnnotation ? Confidence.medium : Confidence.veryLow,
    BoilerplateVersion.v4_mixinBased: hasFactoryAnnotation ? Confidence.medium : Confidence.high,
    BoilerplateVersion.noGenerate: hasFactoryAnnotation ? Confidence.veryLow : Confidence.high,
  };

  bool get hasFactoryAnnotation => node.hasAnnotationWithName('Factory');

  @override
  void validate(BoilerplateVersion version, ValidationErrorCollector errorCollector) {
    switch (version) {
      case BoilerplateVersion.noGenerate:
        return;
      case BoilerplateVersion.v4_mixinBased:
        break;
      case BoilerplateVersion.v2_legacyBackwardsCompat:
      case BoilerplateVersion.v3_legacyDart2Only:
        if (!hasFactoryAnnotation) {
          errorCollector.addError('Legacy boilerplate factories must be annotated with `@Factory()`.',
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
      errorCollector.addError('Should be Should reference generated factory. For example, `UiFactory<...> Foo = _\$Foo;`',
          errorCollector.spanFor(variable));
    } else {
      // When not null, this will be validated as part of the group since
    }
  }

  String get generatedFactoryReferenceName {
    return node.variables.variables.first.initializer
        ?.tryCast<Identifier>()
        ?.nameWithoutPrefix;
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

