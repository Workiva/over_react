import 'package:over_react/over_react.dart';

part 'string_example_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<StringExampleProps> StringExample = _$StringExample;

@Props()
class _$StringExampleProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class StringExampleProps extends _$StringExampleProps {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForStringExampleProps;
}

@Component2()
class StringExampleComponent extends UiComponent2<StringExampleProps> {
  @override
  render() {
    return 'Look, no element!';
  }
}
