import 'package:over_react/over_react.dart';

import 'test_context.dart';

part 'context_provider_component.over_react.g.dart';

@Factory()
UiFactory<ContextProviderWrapperProps> ContextProviderWrapper = _$ContextProviderWrapper;

@Props()
class _$ContextProviderWrapperProps extends UiProps {}

@State()
class _$ContextProviderWrapperState extends UiState {
  int latestValue;
}

@Component2()
class ContextProviderWrapperComponent extends UiStatefulComponent2<ContextProviderWrapperProps, ContextProviderWrapperState> {

  init(){
    initializeState(newState()..latestValue = 1);
  }
  // --------------------------------------------------------------------------
  // React Component Specifications and Lifecycle Methods
  // --------------------------------------------------------------------------
  @override
  Map getDefaultProps() => (newProps());

  @override
  render() {
    return (someContext.Provider()..value = this.state.latestValue)(
      props.children
    );
  }

  // --------------------------------------------------------------------------
  // Public API Methods
  // --------------------------------------------------------------------------
  void increment() {
    this.setState(
      (newState()
        ..latestValue = (this.state.latestValue + 1)
      )
    );
  }
}
