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

@Component()
class BasicComponent extends UiComponent<BasicProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps'; // ignore: deprecated_member_use

  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
        Dom.div()('default prop testing: ${props.basicProp}'), // ignore: deprecated_member_use
        Dom.div()('default prop testing: ${props.basic1}'),
    );
  }
}


