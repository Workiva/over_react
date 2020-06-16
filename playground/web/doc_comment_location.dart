import 'package:over_react/over_react.dart';

part 'incorrect_doc_comment_location.over_react.g.dart';

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
/// It also should not be here.
@State()
class BarState extends UiState {}

/// This doc comment should not be here.
@Component2()
class BarComponent extends UiStatefulComponent2<BarProps, BarState> {
  @override
  render() {}
}

/// This doc comment is okay.
UiFactory<AnotherBarPropsMixin> AnotherBar = _$AnotherBar; // ignore: undefined_identifier

/// This doc comment should not be here.
mixin AnotherBarPropsMixin on UiProps {}

/// This doc comment should not be here.
mixin AnotherBarStateMixin on UiState {}

/// This doc comment should not be here.
class AnotherBarComponent extends AbstractBarComponent<AnotherBarPropsMixin, AnotherBarStateMixin> {
  @override
  render() {}
}

abstract class AbstractBarComponent<P extends UiProps, S extends UiState> extends UiStatefulComponent2<P, S> {}

/// This doc comment is okay.
class RandomClass {}
