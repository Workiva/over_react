import 'package:over_react/over_react.dart';

part 'doc_comment_location.over_react.g.dart';

@Factory()
UiFactory<BarProps> Bar = _$Bar; // ignore: undefined_identifier

/// This doc comment should not be here.
@Props()
class BarProps extends UiProps {}

/// This is a
/// multiple
/// line
/// doc comment.
///
/// It also should not be here (if there's no doc comment on the factory).
@State()
class BarState extends UiState {}

/// This doc comment should not be here (if there's no doc comment on the factory).
@Component2()
class BarComponent extends UiStatefulComponent2<BarProps, BarState> {
  @override
  render() {}
}

/// This doc comment is on the factory.
UiFactory<AnotherBarPropsMixin> AnotherBar = _$AnotherBar; // ignore: undefined_identifier

/// This doc comment is okay because the factory already has a doc comment.
mixin AnotherBarPropsMixin on UiProps {}

mixin AnotherBarStateMixin on UiState {}

class AnotherBarComponent extends AbstractBarComponent<AnotherBarPropsMixin, AnotherBarStateMixin> {
  @override
  render() {}
}

/// This doc comment is okay.
abstract class AbstractBarComponent<P extends UiProps, S extends UiState> extends UiStatefulComponent2<P, S> {}

/// This doc comment is okay.
class RandomClass {}

/// This doc comment is okay.
mixin FooPropsMixin on UiProps {
  bool isBar;
}

UiFactory<FooPropsMixin> FooPropsMixinMapView =
    _$FooPropsMixinMapView; // ignore: undefined_identifier
