import 'package:over_react/over_react.dart';

part 'prop_validation.over_react.g.dart';

@Factory()
UiFactory<FooProps> Foo = _$Foo;

@Props()
class _$FooProps extends UiProps {
  int count;
  List twoObjects;
  int defaultCount;
  bool content;

  bool hideHeader;
  dynamic header;

  List initiallyExpandedKeys;
  var targetKey;

  bool hideLabel;
  String label;
}

@Component2()
class FooComponent extends UiComponent2<FooProps> {
  @override
  render() => 'test';

  // One variation of what the API could look like.
  //
  // This is closer to what it looks like in JS, but might be confusing syntax.
  @override
  get propTypes => {
    propKey((props) => props.twoObjects): (FooProps props, String propName, String componentName, String location, String propFullName) {
      final length = props.twoObjects?.length;
      if (length != 2) {
        return new PropError.value(length, propName, 'must have a length of 2');
      }
    },
  };

}
