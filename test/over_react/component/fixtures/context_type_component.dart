import 'package:over_react/over_react.dart';

import 'test_context.dart';

part 'context_type_component.over_react.g.dart';

@Factory()
UiFactory<ContextTypeProps> ContextType = _$ContextType;

@Props()
class _$ContextTypeProps extends UiProps {}

@Component2()
class ContextTypeComponent extends UiComponent2<ContextTypeProps> {

  @override
  final contextType = someContext.reactDartContext;

  // --------------------------------------------------------------------------
  // React Component Specifications and Lifecycle Methods
  // --------------------------------------------------------------------------

  @override
  Map getDefaultProps() => (newProps());

  @override
  render() {
    return Dom.span()('${this.context}');
  }

  // --------------------------------------------------------------------------
  // Private Utility Methods
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // Public Utility Methods
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // Public API Methods
  // --------------------------------------------------------------------------
}
