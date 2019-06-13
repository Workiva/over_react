

/// Then, in react-dart:
///
/// ```diff
///  final staticComponentInstance = componentFactory();
///
/// ...
///
/// +final propTypes = staticComponentInstance.propTypes;
/// +final jsPropTypes = jsifyAndAllowInterio(propTypes.map((propKey, validator) {
/// +  dynamic handlePropValidator(JsMap props, String propName, String componentName) {
/// +    return validator(JsBackedMap.backedBy(props), propName, componentName);
/// +  }
/// +  return MapEntry(propKey, handlePropValidator);
/// +}));
/// +reactClass.propTypes = jsPropTypes;
/// ```
library foo;


import 'package:over_react/over_react.dart';

class FooProps extends UiProps {
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

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() => null;

  // One variation of what the API could look like.
  //
  // This is closer to what it looks like in JS, but might be confusing syntax.
  @override
  get typedPropTypes => {
    ...super.typedPropTypes,

    propKey((spy) => spy.twoObjects): (props, propName, _) {
      final length = props.twoObjects?.length;
      if (length != 2) {
        return new PropError.value(length, propName, 'must have a length of 2');
      }
    },

  };

  //
  // An alternate variation of what the API could look like.
  //
  // Syntax is still a little iffy.
  //
  @override
  get propTypes => {
    ...super.propTypes,

    ...propValidator((spy) => spy.twoObjects, (props, propName, _) {
      final length = props.twoObjects?.length;
      if (length != 2) {
        return new PropError.value(length, propName, 'must have a length of 2');
      }
    }),


    //
    // More examples that could be implemented in either variation:
    //
    ...propValidator((spy) => spy.count, (props, propName, componentName) {
      if (props.count != null && props.defaultCount != null) {
        return new PropError.combination('count', 'defaultCount', 'cannot be both be set');
      }
    }),

    // From CalloutModal
    ...propValidator((spy) => spy.hideHeader, (props, propName, componentName) {
      if (props.hideHeader) {
        return new PropError.value(props.hideHeader, propName, '${componentName}s must have a visible header.');
      }
    }),
    ...propValidator((spy) => spy.header, (props, propName, componentName) {
      if (props.header == null || props.header == '') {
        return new PropError.value(props.header, propName, '${componentName}s must have a non-empty header.');
      }
    }),

    // From ToggleInput
    ...propValidator((spy) => spy.label, (props, propName, componentName) {
      if (props.label == null) {
        return unindent('''
            This form control does not have a label.
            Every form control should have a label, even if it is hidden (via the `hideLabel` prop).
            See https://dev.workiva.net/docs/api/web_skin_dart/latest/components/forms/#forms-controls-a11y for more info.
        ''');
      } else if (props.hideLabel && props.label is! String) {
        return 'When hideLabel=true, $propName must be a String since it as used as an aria attribute value.';
      }
    }),
  };
}



