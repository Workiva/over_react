library test_components.two_level_wrapper;

import 'package:over_react/over_react.dart';

@Factory()
UiFactory<TwoLevelWrapperProps> TwoLevelWrapper;

@Props()
class TwoLevelWrapperProps extends UiProps {}

@Component(isWrapper: true)
class TwoLevelWrapperComponent extends UiComponent<TwoLevelWrapperProps> {
  @override
  render() => Dom.div()(props.children.single);
}
