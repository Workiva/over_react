import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';

class BoolPropNameReadabilityDiagnostic extends DiagnosticContributor {
  static const code = const ErrorCode(
    'over_react_bool_prop_name_readability',
    "'{0}.{1}' isn't an easily readable Boolean prop name. Try using a prefix like: {2}",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
  );


  @override
  computeErrors(result, collector) async {
    final typeProvider = result.unit.declaredElement.context.typeProvider;
    final visitor = new PropsVisitor();

    result.unit.accept(visitor);

    final returnClasses = visitor.returnClasses;

    for (ClassDeclaration propsClass in returnClasses) {
      final classFields = propsClass.declaredElement.fields;
      for (FieldElement field in classFields) {
        final propName = field.name;
        if (field.type != typeProvider.boolType) continue;
        if (propName == null) continue; // just in case

        List boolPropReadability = checkBoolPropReadability(propName);
        bool isPropReadable = boolPropReadability[0];

        if (!isPropReadable) {
          collector.addError(code, location(result, range: range.node(propsClass.getField(field.name))),
              errorMessageArgs: [propsClass.name, propName, allowedPrefixesForBoolProp.join(', ')]);
        }
      }
    }
  }
}

List checkBoolPropReadability(String propName) {
  List reasons = [];
  bool isReadable = false;
  var checklist = {
    'prefix': hasBooleanPrefix(propName),
    'contains': hasBooleanContain(propName),
    'lowercase': isLowercase(propName),
  };

  checklist.forEach((check, result){
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
  return propName.toLowerCase().startsWith(new RegExp('(${allowedPrefixesForBoolProp.join("|")})'));
}

bool hasBooleanContain(String propName) {
  return propName.toLowerCase().contains(new RegExp('(${allowedContainsForBoolProp.join("|")})'));
}

bool isPropsClass(ClassDeclaration c) =>
    c.declaredElement.allSupertypes.any((m) => m.name == 'UiProps');

class PropsVisitor extends SimpleAstVisitor<void> {
  List<ClassDeclaration> returnClasses = [];
  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (isPropsClass(node)) {
      returnClasses.add(node);
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
