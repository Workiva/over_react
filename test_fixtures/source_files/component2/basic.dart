import 'package:over_react/over_react.dart';

part 'basic.over_react.g.dart';

@Factory()
UiFactory<BasicProps> Basic = _$Basic;

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$BasicProps extends UiProps {
  /// Test that doc comment is copied over.
  @deprecated
  @requiredProp
  String basicProp;

  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;

  static const String defaultProps = 'some_default_props';
  static String get defaultGetter => 'some_defualt_getter';
}

@Component2()
class Basic2Component extends UiComponent2<BasicProps> {
  @override
  Map get defaultProps => newProps()..id = 'basic 2 component'
      ..basicProp = 'defaultBasic2Props'; // ignore: deprecated_member_use

  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
        Dom.div()('default prop testing: ${props.basicProp}'), // ignore: deprecated_member_use
        Dom.div()('default prop testing: ${props.basic1}'),
    );
  }
}


