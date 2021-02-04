part of 'library.dart';

UiFactory<BasicPartOfLibProps> BasicPartOfLib = castUiFactory(_$BasicPartOfLib); // ignore: undefined_identifier

mixin BasicPartOfLibProps on UiProps {
  String basicProp;
}

class BasicPartOfLibComponent extends UiComponent2<BasicPartOfLibProps> {
  @override
  render() {
    return Dom.div()('foo');
  }
}
