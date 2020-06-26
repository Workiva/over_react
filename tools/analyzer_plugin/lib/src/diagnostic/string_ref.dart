import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref.dart' show addCreateRef;
import 'callback_ref.dart';

const _desc = r'Avoid using deprecated string refs.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** to use the return value of `createRef()` as the ref field value 
since string refs are deprecated in ReactJS.

**GOOD:**
```
class NavItemWrapperComponent extends UiComponent<NavItemWrapperProps> {
  final _navItemRef = createRef<NavItemComponent>();
  
  @override
  render() {
    return Fragment()(
      (NavItem()
        ..modifyProps(addUnconsumedProps)
        ..ref = _navItemRef
      )(props.children),
      (Dom.button()
        ..type = 'button'
        ..onClick = _handleClick
      )('Activate the item'),
    );
  }
  
  void _handleClick(_) {
    _navItemRef.current.activate();
  }
}
```

**BAD:**
```
class NavItemWrapperComponent extends UiComponent<NavItemWrapperProps> {
  @override
  render() {
    return Fragment()(
      (NavItem()
        ..modifyProps(addUnconsumedProps)
        ..ref = '_navItemRef'
      )(props.children),
      (Dom.button()
        ..type = 'button'
        ..onClick = _handleClick
      )('Activate the item'),
    );
  }
  
  void _handleClick(_) {
    (ref('_navItemRef') as NavItemComponent).activate();
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

/// A diagnostic that warns the user about String ref usage.
///
/// > See: [addCreateRef], [CallbackRefDiagnostic]
class StringRefDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_string_ref',
    'String refs are deprecated.',
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.HINT,
    correction: 'Use createRef() instead.',
  );

  static final fixKind = FixKind(code.name, 200, 'Convert to createRef()');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    for (final prop in usage.cascadedProps) {
      if (prop.name.name == 'ref' && prop.rightHandSide.staticType.isDartCoreString) {
        await collector.addErrorWithFix(
          code,
          result.locationFor(prop.rightHandSide),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            addCreateRef(builder, usage, result);
          }),
        );
      }
    }
  }
}
