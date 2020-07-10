import 'dart:developer';

import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/prop_errors.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client/react_interop.dart';

// ignore_for_file: uri_has_not_been_generated
part 'function_component.over_react.g.dart';

mixin BasicPropsMixin on UiProps {
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
}

UiFactory<BasicPropsMixin> Basic = uiFunctionComponent((props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(props.basic3, 'children: ${props.children}'),
  );
}, $BasicPropsMixinConfig);

UiFactory<BasicPropsMixin> Basic2 = uiFunctionComponent((props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(props.basic3, 'children: ${props.children}'),
  );
}, $BasicPropsMixinConfig);


// 1. Memory leak?
// 2. Async control-flow is halted







final Simple = uiFunctionComponent<BasicPropsMixin>((props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
}, $BasicPropsMixinConfig, initStatics: (statics) {
  statics.defaultProps = (statics.newProps()
    ..basicProp = 'basicProp'
    ..basic1 = 'basic1'
  );
});



final Simple2 = uiFunctionComponent<BasicPropsMixin>((props) {
  return Dom.div()(
    Dom.div()('prop id: ${props.id}'),
    Dom.div()('default prop testing: ${props.basicProp}'),
    Dom.div()('default prop testing: ${props.basic1}'),
    Dom.div()(null, props.basic4, 'children: ${props.children}'),
  );
}, $BasicPropsMixinConfig, initStatics: (statics) {
  statics
    ..defaultProps = (statics.newProps()
      ..basicProp = 'basicProp'
      ..basic1 = 'basic1'
    )
    ..propTypes = {
      statics.keyFor((p) => p.basicProp): (props, __) {
        if (props.id == 'id') return PropError.value(props.id, 'id', 'That isn\'t a very descriptive ID.');
        return null;
      }
    };
});




//UiFactory<BasicPropsMixin> Basic2 = (BasicPropsMixin props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(null, props.basic4, 'children: ${props.children}'),
//  );
//}.withTypedProps($Basic.factoryFactory);
//
//
//
//UiFactory<BasicPropsMixin> Basic5 = (BasicPropsMixin props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(null, props.basic4, 'children: ${props.children}'),
//  );
//}.asFunctionComponent();
//
//
//UiFactory<BasicPropsMixin> Basic3 = functionBuilder<BasicPropsMixin>().function((props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(null, props.basic4, 'children: ${props.children}'),
//  );
//}.asFunctionComponent();
//


//extension on ReactDartFunctionComponentFactoryProxy {
//  UiFactory<T> withTypedProps<T extends UiProps>(FunctionFactoryFactory<T> factoryFactory) {
//    return factoryFactory(this);
//  }
//  UiFactory<T> withTypedPropsFromOtherFactory<T extends UiProps>(UiFactory<T> otherFactory) {
//    T uiFactory([Map backingProps]) => otherFactory(backingProps)..componentFactory = this;
//    return uiFactory;
//  }
//}

ReactElement functionComponentContent() {
  // FIXME look into naming
  final genericFactory = uiFunctionComponent<UiProps>((props) {
    debugger();
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
    );
  }, null);

//
//
//  UiFactory otherFactory;
//  Object closureVariable;
//
//  final hocFactory = uiFunctionComponent<BasicPropsMixin>((props) {
//    return otherFactory()(
//      Dom.div()('closureVariable: ${closureVariable}'),
//      Dom.div()('prop basic1: ${props.basic1}'),
//    );
//  }, $basicConfig);

  final basicFactory = uiFunctionComponent<BasicPropsMixin>((props) {
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
      Dom.div()('prop basic1: ${props.basic1}'),
    );
    // FIXME should displayName really default to "Basic" in this case?
  }, $BasicPropsMixinConfig, displayName: 'basicFactory');

  return Fragment()(
    (genericFactory()..id = '1')(),
    (basicFactory()..id = '2'..basic1 = 'basic1 value')(),
    (Basic()..id = '3'..basicProp = 'basicProp')(),
    (Simple()..basicProp = 'basicProp')(),
  );
}
