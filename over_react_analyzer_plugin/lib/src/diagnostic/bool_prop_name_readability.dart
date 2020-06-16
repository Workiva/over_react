import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

class BoolPropNameReadabilityDiagnostic extends DiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_bool_prop_name_readability',
    "'{0}.{1}' isn't an easily readable Boolean prop name. Try using a prefix like: {2}",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
  );

  @override
  computeErrors(result, collector) async {
    final typeProvider = result.unit.declaredElement.context.typeProvider;
    final visitor = PropsVisitor();

    result.unit.accept(visitor);

    final returnMixins = visitor.returnMixins;

    for (final propsClass in returnMixins) {
      final mixinFields = propsClass.declaredElement.fields;
      for (final field in mixinFields) {
        final propName = field.name;
        if (field.type != typeProvider.boolType) continue;
        if (propName == null) continue; // just in case

        final boolPropReadability = checkBoolPropReadability(propName);
        final isPropReadable = boolPropReadability[0];

        if (!isPropReadable) {
          collector.addError(code, result.locationFor(propsClass.getField(field.name)),
              errorMessageArgs: [propsClass.name, propName, allowedPrefixesForBoolProp.join(', ')]);
        }
      }
    }
  }
}

List checkBoolPropReadability(String propName) {
  final reasons = [];
  var isReadable = false;
  final checklist = {
    'prefix': hasBooleanPrefix(propName),
    'contains': hasBooleanContain(propName),
    'lowercase': isLowercase(propName),
  };

  checklist.forEach((check, result) {
    if (result) {
      isReadable = true;
      reasons.add(check);
    }
  });

  return [isReadable, reasons];
}

bool isLowercase(String str) {
  return str == str.toLowerCase();
}

bool hasBooleanPrefix(String propName) {
  return propName.toLowerCase().startsWith(RegExp('(${allowedPrefixesForBoolProp.join("|")})'));
}

bool hasBooleanContain(String propName) {
  return propName.toLowerCase().contains(RegExp('(${allowedContainsForBoolProp.join("|")})'));
}

bool isPropsClass(ClassDeclaration classDecl) {
  return classDecl.declaredElement.allSupertypes.any((m) => m.getDisplayString() == 'UiProps');
}

bool isPropsMixin(MixinDeclaration mixinDecl) {
  return mixinDecl.onClause.superclassConstraints.any((m) => m.name.name == 'UiProps');
}

class PropsVisitor extends SimpleAstVisitor<void> {
  List<ClassOrMixinDeclaration> returnMixins = [];
  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (isPropsClass(node)) {
      returnMixins.add(node);
    }
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    if (isPropsMixin(node)) {
      returnMixins.add(node);
    }
  }
}

const allowedPrefixesForBoolProp = [
  'is',
  'was',
  'has',
  'can',
  'should',
  'use',
  'check',
  'show',
  'hide',
  'allow',
];

const allowedContainsForBoolProp = [
  'able',
  'are',
  'checked',
  'suppress',
  'open',
  'close',
  'renderas',
  'initially',
];
