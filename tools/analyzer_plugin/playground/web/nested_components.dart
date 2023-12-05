import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'nested_components.over_react.g.dart';

UiFactory<FooProps> Foo = castUiFactory(_$Foo); // ignore: undefined_identifier

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() {
    final a = uiFunction((_) {}, null);
    final b = uiForwardRef((_, __) {}, null);
    final c = connect()(Dom.div);
    final d = memo(Dom.div);
  }
}

UiFactory<UiProps> Bar = uiFunction((props) {
  final a = uiFunction((_) {}, null);
  final b = uiForwardRef((_, __) {}, null);
  final c = connect()(Dom.div);
  final d = memo(Dom.div);
}, _$BarConfig);

UiFactory<UiProps> Baz = uiForwardRef((props, ref) {
  final a = uiFunction((_) {}, null);
  final b = uiForwardRef((_, __) {}, null);
  final c = connect()(Dom.div);
  final d = memo(Dom.div);
}, _$BazConfig);
