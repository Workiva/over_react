import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

const _desc = r'Name boolean props in a way that makes them easy to read and infer their purpose.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** to name boolean props in a way that makes them easy to read.

**GOOD:**
```
mixin NavItemProps on UiProps {
  // Whether the item should appear active
  bool isActive;
}
```

**BAD:**
```
mixin NavItemProps on UiProps {
  // Whether the item should appear active
  bool active;
}
```

''';
// </editor-fold>

class BoolPropNameReadabilityDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_bool_prop_name_readability',
    "'{0}.{1}' isn't an easily readable Boolean prop name.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.LINT,
    correction: "Try using a prefix like: $allowedPrefixesForBoolPropString.",
  );

  @override
  computeErrors(result, collector) async {
    final typeProvider = result.libraryElement.typeProvider;
    final visitor = PropsVisitor();

    result.unit!.accept(visitor);

    final returnMixins = visitor.returnMixins;

    for (final propsClass in returnMixins) {
      final mixinFields = propsClass.declaredElement!.fields;
      for (final field in mixinFields) {
        final propName = field.name;
        if (field.type != typeProvider.boolType) continue;

        final fieldDecl = propsClass.getField(propName);
        if (fieldDecl == null) continue;

        final readability = checkBoolPropReadability(propName);
        if (!readability.isReadable) {
          collector.addError(code, result.locationFor(fieldDecl), errorMessageArgs: [propsClass.name, propName]);
        }
      }
    }
  }
}

class _ReadabilityResult {
  final bool isReadable;
  final List<String> reasons;

  _ReadabilityResult({required this.isReadable, required this.reasons});
}

_ReadabilityResult checkBoolPropReadability(String propName) {
  final reasons = <String>[];
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

  return _ReadabilityResult(isReadable: isReadable, reasons: reasons);
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

class PropsVisitor extends SimpleAstVisitor<void> {
  List<ClassOrMixinDeclaration> returnMixins = [];
  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.declaredElement?.isPropsClass ?? false) {
      returnMixins.add(node);
    }
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    if (node.declaredElement?.isPropsClass ?? false) {
      returnMixins.add(node);
    }
  }
}

const allowedPrefixesForBoolPropString = 'is, was, has, can, should, use, check, show, hide, allow';
final allowedPrefixesForBoolProp = allowedPrefixesForBoolPropString.split(', ');

const allowedContainsForBoolProp = [
  'able',
  'are',
  'checked',
  'suppress',
  'open',
  'close',
  'renders',
  'initially',
];
