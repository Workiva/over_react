part of basic.library;

mixin SuperPartOfLibPropsMixin on UiProps {
  String superProp;
}

abstract class SuperPartOfLibComponent<T extends SuperPartOfLibPropsMixin> extends UiComponent2<T> {
  @override
  get defaultProps => newProps()..id = 'super';

  @override
  render() {
    return Dom.div()('SuperPartOfLib', {
      'props.superProp': props.superProp,
    }.toString());
  }
}

UiFactory<SubPartOfLibProps> SubPartOfLib = _$SubPartOfLib; // ignore: undefined_identifier

class SubPartOfLibProps = UiProps with SuperPartOfLibPropsMixin, SubPartOfLibPropsMixin;

mixin SubPartOfLibPropsMixin on UiProps, SuperPartOfLibPropsMixin {
  String subProp;
}

class SubPartOfLibComponent extends SuperPartOfLibComponent<SubPartOfLibProps> {
  @override
  get defaultProps => newProps()..id = 'sub';

  @override
  render() {
    return Dom.div()('SubPartOfLib', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
    }.toString());
  }
}