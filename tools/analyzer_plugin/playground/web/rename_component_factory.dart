import 'package:over_react/over_react.dart';

part 'rename_component_factory.over_react.g.dart';

@Factory()
UiFactory<RenameMeProps> RenameMe = _$RenameMe; // ignore: undefined_identifier

@Props()
class RenameMeProps extends UiProps {}

@State()
class RenameMeState extends UiState {}

@Component2()
class RenameMeComponent extends UiStatefulComponent2<RenameMeProps, RenameMeState> {
  @override
  dynamic render() {}
}

UiFactory<RenameMeTooProps> RenameMeToo = _$RenameMeToo; // ignore: undefined_identifier

mixin RenameMeTooProps on UiProps {}

mixin RenameMeTooState on UiState {}

class RenameMeTooComponent extends UiStatefulComponent2<RenameMeTooProps, RenameMeTooState> {
  @override
  void render() {}
}

UiFactory<AndMeProps> AndMe = _$AndMe; // ignore: undefined_identifier

mixin AndMePropsMixin on UiProps {}

class AndMeProps = UiProps with FluxUiPropsMixin, AndMePropsMixin;

class AndMeComponent extends FluxUiComponent2<AndMeProps> {
  @override
  void render() {}
}
