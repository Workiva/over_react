// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';

part 'basic.over_react.g.dart';

@Factory()
UiFactory<BasicProps> Basic = _$Basic;

@Props()
class _$BasicProps extends UiProps {
  @Deprecated('This is deprecated')
  @requiredProp
  String basicProp;

  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class BasicComponent extends UiComponent<BasicProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps';


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


