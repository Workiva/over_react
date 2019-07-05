import 'package:over_react/over_react.dart';

import 'prop_validation.dart';
import 'button.dart';

part 'prop_validation_wrap.over_react.g.dart';

@Factory()
UiFactory<PropTypesWrapProps> PropTypesWrap = _$PropTypesWrap;

@Props()
class _$PropTypesWrapProps extends UiProps {
}

@State()
class _$PropTypesWrapState extends UiState {
  List twoObjects;
}

@Component2()
class PropTypesWrapComponent extends UiStatefulComponent2<PropTypesWrapProps, PropTypesWrapState> {

  @override
  Map getInitialState() => newState()..twoObjects = [1,2];

  @override
  render() {
    return Fragment()(
      (PropTypes()..twoObjects = this.state.twoObjects)(),
      (Button()..onClick = (_){this.setState(newState()..twoObjects = []);})('Click me to pass in an invalid prop')
    );
  }
}
