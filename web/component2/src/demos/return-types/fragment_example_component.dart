import 'package:over_react/over_react.dart';

part 'fragment_example_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FragmentExampleProps> FragmentExample = _$FragmentExample;

@Props()
class _$FragmentExampleProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FragmentExampleProps extends _$FragmentExampleProps {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFragmentExampleProps;
}

@Component2()
class FragmentExampleComponent extends UiComponent2<FragmentExampleProps> {
  @override
  render() {
    return Fragment()(
      Dom.div()('Hi!'),
      Dom.div()('We are wrapped by a fragment!'),
    );
  }
}
