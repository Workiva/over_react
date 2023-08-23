import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref.dart' show addUseOrCreateRef;
import 'string_ref.dart';

const _desc = r'Avoid using callback refs to assign ref field values.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** to use the return value of `createRef()` as the ref field value.

**GOOD:**
```
class NavItemWrapperComponent extends UiComponent<NavItemWrapperProps> {
  final _navItemRef = createRef<NavItemComponent>();
  
  @override
  render() {
    return (NavItem()
      ..modifyProps(addUnconsumedProps)
      ..ref = _navItemRef
    )(props.children);
  }
}
```

**BAD:**
```
class NavItemWrapperComponent extends UiComponent<NavItemWrapperProps> {
  NavItemComponent _navItemRef;
  
  @override
  render() {
    return (NavItem()
      ..modifyProps(addUnconsumedProps)
      ..ref = (ref) { _navItemRef = ref; }
    )(props.children);
  }
}
```

<blockquote>
  <a href="https://reactjs.org/docs/refs-and-the-dom.html#creating-refs" target="_blank" rel="noreferrer noopener">
    Read more about <code>createRef()</code>
  </a>
</blockquote>

''';
// </editor-fold>

/// A diagnostic that warns the user about callback ref usage.
///
/// > See: [addUseOrCreateRef], [StringRefDiagnostic]
class CallbackRefDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_prefer_use_or_create_ref',
    _desc,
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.HINT,
    correction: 'Use the return value of useRef() / createRef() as the ref field value instead.',
  );

  @override
  List<DiagnosticCode> get codes => [code];

  static final fixKind = FixKind(code.name, 200, 'Convert to useRef() / createRef()');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    for (final prop in usage.cascadedProps) {
      if (prop.name.name == 'ref') {
        final rhsStaticType = prop.rightHandSide.staticType;
        if (rhsStaticType != null && result.typeSystem.isSubtypeOf(rhsStaticType, result.typeProvider.functionType)) {
          if (prop.rightHandSide is SimpleIdentifier) {
            // Its a tearoff. The `addUseOrCreateRef` utility we use to build fixes is not
            // yet able to handle tearoff callback refs, so just add the error.
            collector.addError(code, result.locationFor(prop.rightHandSide), hasFix: false);
          } else {
            await collector.addErrorWithFix(
              code,
              result.locationFor(prop.rightHandSide),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                addUseOrCreateRef(builder, usage, result);
              }),
            );
          }
        }
      }
    }
  }
}
