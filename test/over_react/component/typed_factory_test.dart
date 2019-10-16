library typed_factory_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

part 'typed_factory_test.over_react.g.dart';

void main(){
  test('typedPropsFactory falls back to empty backingMap when called with null', () {
    var toCheck = _$TypedFactoryTesterComponent().typedPropsFactory(null);
    toCheck.testProp = true;

    expect(toCheck.testProp, isTrue);
    expect(toCheck, isA<Map>());
  });

  test('typedStateFactory falls back to empty backingMap when called with null', () {
    var toCheck = _$TypedFactoryTesterComponent().typedStateFactory(null);
    toCheck.testState = true;

    expect(toCheck.testState, isTrue);
    expect(toCheck, isA<Map>());
  });
}


@Factory()
UiFactory<TypedFactoryTesterProps> TypedFactoryTester = _$TypedFactoryTester;

@Props()
class _$TypedFactoryTesterProps extends UiProps {
  bool testProp;
}

@State()
class _$TypedFactoryTesterState extends UiState {
  bool testState;
}

@Component2()
class TypedFactoryTesterComponent extends UiStatefulComponent2<TypedFactoryTesterProps, TypedFactoryTesterState> {
  @override
  render() => null;
}
