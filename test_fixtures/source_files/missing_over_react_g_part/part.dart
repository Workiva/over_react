part of 'library.dart';

@Factory()
UiFactory<BasicPartOfLibProps> BasicPartOfLib = _$BasicPartOfLib;

@Props()
class _$BasicPartOfLibProps extends UiProps {
  String basicProp;
}

@Component()
class BasicPartOfLibComponent extends UiComponent<BasicPartOfLibProps> {
  @override
  render() {
    return Dom.div()('foo');
  }
}
