import 'package:over_react/over_react.dart';
// ignore: uri_has_not_been_generated
part 'stateless_component.over_react.g.dart';

@Factory()
UiFactory<StatelessProps> Stateless =
    // ignore: undefined_identifier
    _$Stateless;

@Props()
class _$StatelessProps extends UiProps {}

@Component()
class StatelessComponent extends UiComponent<StatelessProps> {
  @override
  render() { }
}

// This will be removed once the transition to Dart 2 is complete.
class StatelessProps extends _$StatelessProps
    with
        // ignore: mixin_of_non_class, undefined_class
        _$StatelessPropsAccessorsMixin {
  // ignore: const_initialized_with_non_constant_value, undefined_class, undefined_identifier
  static const PropsMeta meta = _$metaForStatelessProps;
}
