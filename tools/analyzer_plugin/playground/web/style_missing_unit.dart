import 'package:over_react/over_react.dart';

part 'style_missing_unit.over_react.g.dart';

styleMissingUnit() {
  (Dom.div()..style = {
    'width': '1',
    'height': '1.2',
    // no warning because valid unit
    'top': '1px',
    'left': '1rem',
    // no warning because blacklisted property
    'opacity': '1',
    // no warning because custom property
    '--custom-property': '1',
  })();

  // handles nested maps
  (Dom.div()..style = newStyleFromProps({
    'width': '1',
  }))();

  const ten = '10';
  const two = '2px';
  final three = '3';

  // Non-SimpleStringLiteral cases detected (but don't have assists)
  (Dom.div()..style = {
    'width': ten, // Should lint
    'minWidth': two, // Should not lint
    'minHeight': three, // Cannot lint currently since its not const, but also should not cause analyzer errors
    'height': '1' '2',
    'top': '${1}',
    'left': 1,
  })();
}

UiFactory<SomeWidgetWithBadStylesProps> SomeWidgetWithBadStyles =
    // ignore: undefined_identifier
    _$SomeWidgetWithBadStyles;

mixin SomeWidgetWithBadStylesProps on UiProps {}

class SomeWidgetWithBadStylesComponent extends UiComponent2<SomeWidgetWithBadStylesProps> {
  static const ten = '10';
  static const two = '2px';

  @override
  render() {
    return (Dom.div()..style = {
      'width': ten, // Should lint
      'minWidth': two, // Should not lint
    })();
  }
}
