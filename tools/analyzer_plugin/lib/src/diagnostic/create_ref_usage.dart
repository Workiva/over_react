import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

const _desc = r'Prefer useRef over createRef within a function component.';
// <editor-fold desc="Documentation Details">
const _details = r'''

This diagnostic detects when `createRef`, instead of `useRef`, is used inside a function component,
since usually it's a mistake.

`createRef` creates a new ref object each time, while `useRef` persists for the lifetime of the component.

**BAD:** 
```
import 'package:over_react/over_react.dart';

part 'create_ref_usage.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    final ref = createRef();

    return (Dom.div()..ref = ref)();
  },
  _$FooConfig, // ignore: undefined_identifier
);

mixin FooProps on UiProps {}
```

**GOOD:**
```
import 'package:over_react/over_react.dart';

part 'create_ref_usage.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    final ref = useRef();

    return (Dom.div()..ref = ref)();
  },
  _$FooConfig, // ignore: undefined_identifier
);

mixin FooProps on UiProps {}
```

''';
// </editor-fold>

class CreateRefUsageDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_create_ref_usage',
    "Prefer useRef over createRef within function components.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  @override
  List<DiagnosticCode> get codes => [code];

  static final fixKind = FixKind(code.name, 400, "Replace with useRef");

  @override
  computeErrors(result, collector) async {
    final unit = result.unit;
    for (final component in getAllFunctionComponents(unit)) {
      final visitor = CreateRefUsageVisitor();
      component.body.accept(visitor);
      for (final createRefInvocation in visitor.createRefInvocations) {
        await collector.addErrorWithFix(
          code,
          result.locationFor(createRefInvocation),
          fixKind: fixKind,
          computeFix: () => buildGenericFileEdit(result, (builder) {
            builder.addSimpleReplacement(range.node(createRefInvocation), 'useRef');
          }),
        );
      }
    }
  }
}

class CreateRefUsageVisitor extends GeneralizingAstVisitor<void> {
  final createRefInvocations = <SimpleIdentifier>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);
    final methodName = node.methodName;
    final uri = methodName.staticElement?.source?.uri;

    if (methodName.name == 'createRef' && uri != null && isUriWithinPackage(uri, 'over_react')) {
      createRefInvocations.add(methodName);
    }
  }
}
