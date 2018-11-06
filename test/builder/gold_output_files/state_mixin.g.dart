part of 'state_mixin.dart';

abstract class $ExampleStateMixinClass implements ExampleStateMixinClass {
  @override  Map get state;

  @override
  String get stateMixin1 => state[_$key__stateMixin1__ExampleStateMixinClass];
  @override
  set stateMixin1(String value) => state[_$key__stateMixin1__ExampleStateMixinClass] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__stateMixin1__ExampleStateMixinClass = const StateDescriptor(_$key__stateMixin1__ExampleStateMixinClass);
  static const String _$key__stateMixin1__ExampleStateMixinClass = 'ExampleStateMixinClass.stateMixin1';

  static const List<StateDescriptor> $state = const [_$prop__stateMixin1__ExampleStateMixinClass];
  static const List<String> $stateKeys = const [_$key__stateMixin1__ExampleStateMixinClass];
}

const StateMeta $metaForExampleStateMixinClass = const StateMeta(
  fields: $ExampleStateMixinClass.$state,
  keys: $ExampleStateMixinClass.$stateKeys,
);

