import 'package:over_react/over_react.dart';
import './basic_component_2.dart';

part 'inherited_component_2.over_react.g.dart';

@Factory()
UiFactory<InheritedProps> Inherited = _$Inherited;

@Props()
class _$InheritedProps extends Basic2Props {
}

@Component()
class InheritedComponent extends Basic2Component {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultInheritedProps'; // ignore: deprecated_member_use


  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
        Dom.div()('default prop testing: ${props.basicProp}'), // ignore: deprecated_member_use
        Dom.div()('default prop testing: ${props.basic1}'),
        Dom.div()(null, props.basic4, 'children: ${props.children}' ),
    );
  }
}


