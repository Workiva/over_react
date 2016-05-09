library test_util.wrapper_component;

import 'package:web_skin_dart/ui_core.dart';

/// A helper component for use in tests where a component needs to be
/// rendered inside a wrapper, but a composite component must be used
/// for compatability with `getByTestId()`.
@Factory()
UiFactory<UiProps> Wrapper;

@Props()
class WrapperProps extends UiProps {}

@Component()
class WrapperComponent extends UiComponent<WrapperProps> {
  @override
  render() => (Dom.div()..addAll(props))(props.children);
}
