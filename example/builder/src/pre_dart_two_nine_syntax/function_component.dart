import 'package:over_react/over_react.dart';

part 'function_component.over_react.g.dart'; // ignore: uri_has_not_been_generated

UiFactory<FunctionComponentProps> FunctionComponent = uiFunction(
  (props) {
    return Dom.div()(
      'This is a pre-Dart 2.9.0 functional component.'
    );
  },
  _$FunctionComponentConfig, // ignore: undefined_identifier
);

mixin FunctionComponentProps on UiProps {}