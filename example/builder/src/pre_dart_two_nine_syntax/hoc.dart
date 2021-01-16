import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../../main.dart';

part 'hoc.over_react.g.dart';

UiFactory<HocProps> Hoc = connect<ExampleState, HocProps>(
  mapStateToPropsWithOwnProps: (state, props) => Hoc(),
  mapDispatchToPropsWithOwnProps: (state, props) => Hoc(),
)(_$Hoc); // ignore: undefined_identifier

mixin HocProps on UiProps {
  String foo;
}

class HocComponent extends UiComponent2<HocProps> {
  @override
  render() => Dom.div()(props.foo);
}

UiFactory<HocWithTwoFactoriesProps> HocWithTwoFactories = _$HocWithTwoFactories; // ignore: undefined_identifier

UiFactory<HocWithTwoFactoriesProps> ConnectedHocWithTwoFactories = connect<ExampleState, HocWithTwoFactoriesProps>(
  mapStateToPropsWithOwnProps: (state, props) => HocWithTwoFactories(),
  mapDispatchToPropsWithOwnProps: (state, props) => HocWithTwoFactories(),
)(HocWithTwoFactories);

mixin HocWithTwoFactoriesProps on UiProps {
  String foo;
}

class HocWithTwoFactoriesComponent extends UiComponent2<HocWithTwoFactoriesProps> {
  @override
  render() => Dom.div()(props.foo);
}
