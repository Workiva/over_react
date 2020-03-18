import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'dom_props_playground.over_react.g.dart';

UiFactory<DomPropsPlaygroundProps> DomPropsPlayground = _$DomPropsPlayground; // ignore: undefined_identifier

mixin DomPropsPlaygroundProps on UiProps {}

class DomPropsPlaygroundComponent extends UiComponent2<DomPropsPlaygroundProps> {

  @override
  render() {
    return Dom.div()(
      (Dom.div()..style={'borderStyle': 'solid', 'borderColor': 'blue', 'borderWidth': 1})(
          (Dom.a()..href = 'https://google.com')('No backing')
      ),
      (Dom.div()..style={'borderStyle': 'solid', 'borderColor': 'red', 'borderWidth': 1})(
        (Dom.a(null)..href = 'https://google.com')('Null backing'),
      ),
      (Dom.div()..style={'borderStyle': 'solid', 'borderColor': 'orange', 'borderWidth': 1})(
        (Dom.a({})..href = 'https://google.com')('Map backing'),
      ),
      (Dom.div()..style={'borderStyle': 'solid', 'borderColor': 'purple', 'borderWidth': 1})(
        (Dom.a(JsBackedMap())..href = 'https://google.com')('JsBackedMap Backing'),
      ),
    );
  }
}
