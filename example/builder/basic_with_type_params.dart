import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'basic_with_type_params.over_react.g.dart' as $;
export 'basic_with_type_params.over_react.g.dart';

UiFactory<BasicPropsMixin> Basic = $.Basic;

mixin BasicPropsMixin<T, U extends UiProps> on UiProps {
  List<T> someGenericListProp;
  U somePropsClass;
}

class BasicComponent extends UiComponent2<BasicPropsMixin> {
  @override
  get defaultProps => newProps()..id = 'basic component';

  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
    );
  }
}


