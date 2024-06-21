//@dart=2.11
import 'package:over_react/over_react.dart';

part 'state_mixin.over_react.g.dart';

@StateMixin()
abstract class ExampleStateMixinClass implements UiState {
  @override
  Map get state;

  static const StateMeta meta = _$metaForExampleStateMixinClass;

  String stateMixin1;
}

