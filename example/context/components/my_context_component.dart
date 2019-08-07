import 'package:over_react/over_react.dart';
import '../store.dart';

part 'my_context_component.over_react.g.dart';

@Factory()
UiFactory<MyContextComponentProps> MyContextComponent = _$MyContextComponent;

@Props()
class _$MyContextComponentProps extends UiProps {

}

@Component2()
class MyContextComponentComponent extends UiComponent2<MyContextComponentProps> {

  @override
  get contextType => someContext.reactDartContext;

  @override
  Map getDefaultProps() => (newProps());

  @override
  render() {
    return Dom.div()('${this.context}');
  }
}
