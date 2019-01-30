import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'stateless_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<StatelessProps> Stateless = $Stateless;

@Props()
class _$StatelessProps extends UiProps {}

@Component()
class StatelessComponent extends UiComponent<StatelessProps> {
  @override
  render() { }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class StatelessProps extends _$StatelessProps with _$StatelessPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForStatelessProps;
}
