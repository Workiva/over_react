library test_components.one_level_wrapper;

import 'package:over_react/ui_core.dart';

@Factory()
UiFactory<OneLevelWrapperProps> OneLevelWrapper;

@Props()
class OneLevelWrapperProps extends UiProps {}

@Component(isWrapper: true)
class OneLevelWrapperComponent extends UiComponent<OneLevelWrapperProps> {
  @override
  render() => Dom.div()(props.children.single);
}
