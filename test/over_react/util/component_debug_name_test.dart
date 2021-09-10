// ignore_for_file: deprecated_member_use_from_same_package

import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/component_debug_name.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';

part 'component_debug_name_test.over_react.g.dart';

void main() {
  group('getDebugNameForDartComponent', () {
    group('returns the displayName it was registered with for a mounted', () {
      test('UiComponent component declared with standard boilerplate', () {
        final component = mount(TestComponent()()).getDartInstance() as UiComponent;
        expect(getDebugNameForDartComponent(component), 'TestComponent');
      });

      test('UiComponent2 component declared with standard boilerplate', () {
        final component = mount(TestComponent2()()).getDartInstance() as UiComponent2;
        expect(getDebugNameForDartComponent(component), 'TestComponent2');
      });
    });

    group('returns the .displayName getter for a non-mounted component', () {
      test('UiComponent component declared with standard boilerplate', () {
        final component = TestNonMountedComponentComponent();
        expect(getDebugNameForDartComponent(component), component.displayName);
      });

      test('UiComponent2 component declared with standard boilerplate', () {
        final component = TestNonMountedComponent2Component();
        expect(getDebugNameForDartComponent(component), component.displayName);
      });
    });
  });
}

@Factory()
UiFactory<TestComponentProps> TestComponent = castUiFactory(_$TestComponent); // ignore: undefined_identifier

@Props()
class _$TestComponentProps extends UiProps {}

@Component()
class TestComponentComponent extends UiComponent<TestComponentProps> {
  @override
  render() {}
}

// ignore: mixin_of_non_class, undefined_class
abstract class TestComponentProps extends _$TestComponentProps with _$TestComponentPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForTestComponentProps;
}

UiFactory<TestComponent2Props> TestComponent2 = castUiFactory(_$TestComponent2); // ignore: undefined_identifier

mixin TestComponent2Props on UiProps {}

class TestComponent2Component extends UiComponent2<TestComponent2Props> {
  @override
  render() {}
}

class TestNonMountedComponentComponent extends UiComponent {
  @override
  render() {}

  @override
  bool get $isClassGenerated => true;
}

class TestNonMountedComponent2Component extends UiComponent2 {
  @override
  render() {}

  @override
  bool get $isClassGenerated => true;
}
