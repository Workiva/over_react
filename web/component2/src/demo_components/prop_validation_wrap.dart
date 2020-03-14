import 'package:over_react/over_react.dart';

import 'prop_validation.dart';
import 'button.dart';

part 'prop_validation_wrap.over_react.g.dart';

UiFactory<PropTypesWrapProps> PropTypesWrap = _$PropTypesWrap;

mixin PropTypesWrapProps on UiProps {}

mixin PropTypesWrapState on UiState {
  List twoObjects;
}

class PropTypesWrapComponent extends UiStatefulComponent2<PropTypesWrapProps, PropTypesWrapState> {
  @override
   get initialState => (newState()..twoObjects = [1,2]
);

  @override
  render() {

    return Fragment()(
      (PropTypesTest()..twoObjects = this.state.twoObjects)(),
      (Button()..onClick = (_){
          this.setState(newState()..twoObjects = []);
        }
      )('Click me to pass in an invalid prop'),
    );
  }
}
