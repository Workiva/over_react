import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

import '../util/util.dart';

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
  List<DiagnosticCode> get codes => [code];

  @override
  computeErrors(result, collector) async {
    final typeProvider = result.libraryElement.typeProvider;
    final visitor = PropFieldVisitor();

    result.unit.accept(visitor);

    for (final tuple in visitor.propFields) {
      final propsClass = tuple.item1;
      final fields = tuple.item2;
      for (final field in fields) {
        for (final variable in field.fields.variables) {
          final propName = variable.name.lexeme;
          if (variable.declaredElement?.type != typeProvider.boolType) continue;

          final readability = checkBoolPropReadability(propName);
          if (!readability.isReadable) {
            collector.addError(code, result.locationFor(variable), errorMessageArgs: [propsClass.name, propName]);
          }
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


class PropFieldVisitor extends SimpleAstVisitor<void> {
  List<Tuple2<NamedCompilationUnitMember, List<FieldDeclaration>>> propFields = [];
  @override
  void visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
  }

  static List<FieldDeclaration> _getPropFields(Iterable<ClassMember> members) =>
      members.whereType<FieldDeclaration>().where((f) => !f.isStatic).toList();

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.declaredElement?.isPropsClass ?? false) {
      propFields.add(Tuple2(node, _getPropFields(node.members)));
    }
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    if (node.declaredElement?.isPropsClass ?? false) {
      propFields.add(Tuple2(node, _getPropFields(node.members)));
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
