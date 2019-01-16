import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'abstract_component.over_react.g.dart';

@AbstractProps()
abstract class _$AbstractStatelessProps extends UiProps {}

@AbstractComponent()
abstract class AbstractStatelessComponent<T extends AbstractStatelessProps> extends UiComponent<T> {
  @override
  render() { }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class AbstractStatelessProps extends _$AbstractStatelessProps with _$AbstractStatelessPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForAbstractStatelessProps;
}
