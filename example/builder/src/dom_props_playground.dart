import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'dom_props_playground.over_react.g.dart';

UiFactory<DomPropsPlaygroundProps> DomPropsPlayground = _$DomPropsPlayground; // ignore: undefined_identifier

mixin DomPropsPlaygroundProps on UiProps {}

class DomPropsPlaygroundComponent extends UiComponent2<DomPropsPlaygroundProps> {

  @override
  render() {
    return Dom.div()(
        (Dom.a()..href='https://google.com')('Heres a link'),
        (Dom.div()..style={'borderStyle': 'solid', 'borderColor': 'blue', 'borderWidth': 1})('Heres a some text')
    );
  }
}
