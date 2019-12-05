import 'package:over_react/over_react.dart';
import 'package:react/react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'function_component.example.over_react.g.dart' as $;

mixin BasicPropsMixin on UiProps {
  @requiredProp
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

UiFactory<BasicPropsMixin> Basic = uiFunctionComponent($.$Basic, (props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
});

// ===========================================================================
//
// Alternate typing forms
//

// Option 2
final Basic2 = uiFunctionComponent<BasicPropsMixin>($.$Basic, (props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
});

// Option 3
final Basic3 = uiFunctionComponent($.$Basic, (BasicPropsMixin props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
});

// ===========================================================================
//
// Default props and propTypes
//

// Note: many of these avoid arrow functions since the formatting sucks

// Option 1
UiFactory<BasicPropsMixin> Basic4 = uiFunctionComponent($.$Basic, (props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
}, getDefaultProps: (newProps) {
  return (newProps()
    ..basicProp = 'basicProp'
    ..basic1 = 'basic1');
});

// Option 1 (with propTypes)
UiFactory<BasicPropsMixin> Basic4WithPropTypes = uiFunctionComponent(
  $.$Basic,
  (props) {
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
      Dom.div()('default prop testing: ${props.basicProp}'),
      Dom.div()('default prop testing: ${props.basic1}'),
      Dom.div()(null, props.basic4, 'children: ${props.children}'),
    );
  },
  getDefaultProps: (newProps) => (newProps()
    ..basicProp = 'basicProp'
    ..basic1 = 'basic1'),
  getPropTypes: (keyFor) => {
    keyFor((p) => p.basicProp): (props, info) {
      if (props.basic1 == '1') {
        return PropError.value(props.basic1, info.propName);
      }
      return null;
    }
  },
);

// Option 2
UiFactory<BasicPropsMixin> Basic5 = uiFunctionComponent2($.$Basic, (props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
}, initStatics: (statics) {
  statics.defaultProps = (statics.newProps()
    ..basicProp = 'basicProp'
    ..basic1 = 'basic1'
  );
});

// Option 2 (with propTypes)
UiFactory<BasicPropsMixin> Basic5WithPropTypes = uiFunctionComponent2($.$Basic, (props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
}, initStatics: (statics) {
  statics
    ..defaultProps = (statics.newProps()
      ..basicProp = 'basicProp'
      ..basic1 = 'basic1'
    )
    ..propTypes = {
      statics.keyFor((p) => p.basicProp): (props, info) {
        if (props.basic1 == '1') {
          return PropError.value(props.basic1, info.propName);
        }
        return null;
      }
    };
});

// ===========================================================================
//
// Helper functions (ignore these)
//

UiFactory<T> uiFunctionComponent<T extends UiProps>(
    ReactComponentFactoryProxy factory,
    dynamic Function(T props) functionComponent,
    {Map Function(BuilderOnlyUiFactory<T> newProps) getDefaultProps,
    Map<String, PropValidator<T>> Function(
      String Function(void Function(T propsMap) accessProp) keyFor,
    )
        getPropTypes}) {}

UiFactory<T> uiFunctionComponent2<T extends UiProps>(
  ReactComponentFactoryProxy factory,
  dynamic Function(T props) functionComponent, {
  void Function(UiFunctionComponentStatics<T>) initStatics,
}) {}

class UiFunctionComponentStatics<T> {
  Map defaultProps;
  Map<String, PropValidator<T>> propTypes;

  UiFunctionComponentStatics._();

  T newProps() {}
  String keyFor(void Function(T) accessProps) {}
}
