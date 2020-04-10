import 'package:over_react/over_react.dart';

part 'prop_validation.over_react.g.dart';

UiFactory<PropTypesTestProps> PropTypesTest = _$PropTypesTest;

mixin PropTypesTestProps on UiProps {
  int count;
  List twoObjects;
  int defaultCount;
  bool content;

  bool hideHeader;
  dynamic header;

  List initiallyExpandedKeys;
  dynamic targetKey;

  bool hideLabel;
  String label;
}

class PropTypesTestComponent extends UiComponent2<PropTypesTestProps> {
  @override
  render() =>
      Fragment()(Dom.code()('props.twoObjects'), ' currently has ${props.twoObjects.length} objects passed to it.');

  // One variation of what the API could look like.
  //
  // This is closer to what it looks like in JS, but might be confusing syntax.
  @override
  get propTypes => {
        keyForProp((p) => p.twoObjects): (props, info) {
          final length = props.twoObjects?.length;
          if (length != 2) {
            return PropError.value(length, info.propName, 'must have a length of 2');
          }
          return null;
        },
      };
}
