import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'basic_with_type_params.example.over_react.g.dart' as $;
export 'basic_with_type_params.example.over_react.g.dart';

UiFactory<BasicPropsMixin> Basic = $.$Basic;

mixin BasicPropsMixin<T, U extends UiProps> on UiProps {
  List<T> someGenericListProp;
  U somePropsClass;
}

class BasicProps<T, U extends UiProps> = UiProps with BasicPropsMixin<T, U>;

class BasicComponent extends UiComponent2<BasicProps> {
  @override
  get defaultProps => newProps()..id = 'basic component';

  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
    );
  }
}


