import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'basic_with_type_params.over_react.g.dart';

UiFactory<BasicPropsMixin> Basic = _$Basic; // ignore: undefined_identifier

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
