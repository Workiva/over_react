import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref.dart' show addCreateRef;
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
/// > See: [addCreateRef], [StringRefDiagnostic]
class CallbackRefDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_prefer_create_ref',
    _desc,
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.HINT,
    correction: 'Use the return value of createRef() as the ref field value instead.',
  );

  static final fixKind = FixKind(code.name, 200, 'Convert to createRef()');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name == 'ref' &&
          result.typeSystem.isSubtypeOf(rhs.staticType, result.typeProvider.functionType)) {
        collector.addErrorWithFix(
          code,
          result.locationFor(rhs),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            addCreateRef(builder, usage, result);
          }),
        );
      }
    });
  }
}
