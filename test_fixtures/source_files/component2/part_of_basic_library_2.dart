part of basic.library;

@AbstractProps()
class _$SuperPartOfLibProps extends UiProps {
  String superProp;
}

@AbstractComponent2()
abstract class SuperPartOfLibComponent<T extends SuperPartOfLibProps> extends UiComponent2<T> {
  @override
  Map get defaultProps => newProps()..id = 'super';

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

@Component2()
class SubPartOfLibComponent extends SuperPartOfLibComponent<SubPartOfLibProps> {
  @override
  Map get defaultProps => newProps()..id = 'sub';

  @override
  render() {
    return Dom.div()('SubPartOfLib', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
    }.toString());
  }
}
