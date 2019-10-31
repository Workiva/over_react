// ignore_for_file: deprecated_member_use_from_same_package
part of basic.library;

@AbstractProps()
class _$SuperPartOfLibProps extends UiProps {
  String superProp;
}

@AbstractComponent()
abstract class SuperPartOfLibComponent<T extends SuperPartOfLibProps> extends UiComponent<T> {
  @override
  Map getDefaultProps() => newProps()..id = 'super';

  @override
  render() {
    return Dom.div()('SuperPartOfLib', {
      'props.superProp': props.superProp,
    }.toString());
  }
}

@Factory()
UiFactory<SubPartOfLibProps> SubPartOfLib = _$SubPartOfLib;

@Props()
class _$SubPartOfLibProps extends SuperPartOfLibProps {
  String subProp;
}

@Component()
class SubPartOfLibComponent extends SuperPartOfLibComponent<SubPartOfLibProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'sub';

  @override
  render() {
    return Dom.div()('SubPartOfLib', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
    }.toString());
  }
}
