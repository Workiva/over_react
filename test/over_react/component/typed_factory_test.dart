library typed_factory_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

part 'typed_factory_test.over_react.g.dart';

void main(){
  test('typedPropsFactory works with null', () {
    var toCheck = _$TypedFactoryTesterComponent().typedPropsFactory(null);
    expect(toCheck, isA<Map>());
  });

  test('typedStateFactory works with null', () {
    var toCheck = _$TypedFactoryTesterComponent().typedStateFactory(null);
    expect(toCheck, isA<Map>());
  });
}


@Factory()
UiFactory<TypedFactoryTesterProps> TypedFactoryTester = _$TypedFactoryTester;

@Props()
class _$TypedFactoryTesterProps extends UiProps {}

@State()
class _$TypedFactoryTesterState extends UiState {}

@Component2()
class TypedFactoryTesterComponent extends UiStatefulComponent2 {
  @override
  render() => null;
}
