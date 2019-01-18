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

// This will be removed once the transition to Dart 2 is complete.
class AbstractStatelessProps extends _$AbstractStatelessProps
    with
        // ignore: mixin_of_non_class, undefined_class
        _$AbstractStatelessPropsAccessorsMixin {
  // ignore: const_initialized_with_non_constant_value, undefined_class, undefined_identifier
  static const PropsMeta meta = _$metaForAbstractStatelessProps;
}
