library test_components.two_level_wrapper;

import 'package:web_skin_dart/ui_core.dart';

@Factory()
UiFactory<TwoLevelWrapperProps> TwoLevelWrapper;

@Props()
class TwoLevelWrapperProps extends UiProps {}

@Component(isWrapper: true)
class TwoLevelWrapperComponent extends UiComponent<TwoLevelWrapperProps> {
  @override
  render() => Dom.div()(props.children.single);
}
