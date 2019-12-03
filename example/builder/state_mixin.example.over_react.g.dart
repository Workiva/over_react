// ignore_for_file: unnecessary_null_in_if_null_operators
import 'package:over_react/over_react.dart';
import 'state_mixin.dart';

mixin $ExampleStateMixinClass implements ExampleStateMixinClass {
  @override
  Map get state;

  static const StateMeta meta = _$metaForExampleStateMixinClass;

  @override String get stateMixin1 => state[_$key__stateMixin1___$ExampleStateMixinClass] ?? null;
  @override set stateMixin1(String value) => state[_$key__stateMixin1___$ExampleStateMixinClass] = value;

  static const _$prop__stateMixin1___$ExampleStateMixinClass =
      StateDescriptor(_$key__stateMixin1___$ExampleStateMixinClass);
  static const _$key__stateMixin1___$ExampleStateMixinClass = 'ExampleStateMixinClass.stateMixin1';

  static const List<StateDescriptor> $state = [_$prop__stateMixin1___$ExampleStateMixinClass];
  static const List<String> $stateKeys = [_$key__stateMixin1___$ExampleStateMixinClass];
}

const StateMeta _$metaForExampleStateMixinClass = StateMeta(
  fields: $ExampleStateMixinClass.$state,
  keys: $ExampleStateMixinClass.$stateKeys,
);
