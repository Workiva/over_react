import 'package:over_react/over_react.dart';

part 'list_example_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<ListExampleProps> ListExample = _$ListExample;

@Props()
class _$ListExampleProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class ListExampleProps extends _$ListExampleProps {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForListExampleProps;
}

@Component2()
class ListExampleComponent extends UiComponent2<ListExampleProps> {
  @override
  render() {
    return [
      Dom.div()('First list item'),
      Dom.div()('Second list item'),
    ];
  }
}
