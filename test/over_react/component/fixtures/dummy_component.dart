import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'dummy_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<DummyProps> Dummy = _$Dummy;

@Props()
class _$DummyProps extends UiProps {
  Function onComponentDidMount;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class DummyProps extends _$DummyProps with _$DummyPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForDummyProps;
}

@Component2()
class DummyComponent extends UiComponent2<DummyProps> {
  @override
  void componentDidMount() {
    props.onComponentDidMount();
  }

  @override
  render() {
    return (Dom.button()
      ..addTestId('DummyButton')
    )('oh hai');
  }
}
