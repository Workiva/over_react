import 'package:over_react/over_react.dart';

part 'basic_component_2.over_react.g.dart';

@Factory()
UiFactory<Basic2Props> Basic2 = _$Basic2;

@Props()
class _$Basic2Props extends UiProps {
  @deprecated
  @requiredProp
  String basicProp;

  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class Basic2Component extends UiComponent2<Basic2Props> {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps'; // ignore: deprecated_member_use


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


