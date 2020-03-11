//import 'dart:developer';
//
//import 'package:js/js_util.dart';
//import 'package:meta/meta.dart';
//import 'package:over_react/over_react.dart';
//import 'package:over_react/src/util/prop_errors.dart';
//import 'package:react/react.dart' as react;
//import 'package:react/react_client.dart';
//import 'package:react/react_client/js_backed_map.dart';
//import 'package:react/react_client/react_interop.dart';
//
//// ignore_for_file: uri_has_not_been_generated
//import 'function_component.over_react.g.dart' as $;
//
//mixin BasicPropsMixin on UiProps {
//  String basicProp;
//  String basic1;
//  String basic2;
//  String basic3;
//  String basic4;
//}
//
//UiFactory<BasicPropsMixin> Basic = uiFunctionComponent((props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(props.basic3, 'children: ${props.children}'),
//  );
//}, _$BasicPropsConfig);
//
//UiFactory<BasicPropsMixin> Basic2 = uiFunctionComponent((props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(props.basic3, 'children: ${props.children}'),
//  );
//}, _$BasicPropsConfig);
//
//
//// 1. Memory leak?
//// 2. Async control-flow is halted
//
//
//
//
//
//
//
//final Simple = uiFunctionComponent<BasicPropsMixin>((props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(null, props.basic4, 'children: ${props.children}'),
//  );
//}, _$BasicPropsConfig, initStatics: (statics) {
//  statics.defaultProps = (statics.newProps()
//    ..basicProp = 'basicProp'
//    ..basic1 = 'basic1'
//  );
//});
//
//
//
//final Simple2 = uiFunctionComponent<BasicPropsMixin>((props) {
//  return Dom.div()(
//    Dom.div()('prop id: ${props.id}'),
//    Dom.div()('default prop testing: ${props.basicProp}'),
//    Dom.div()('default prop testing: ${props.basic1}'),
//    Dom.div()(null, props.basic4, 'children: ${props.children}'),
//  );
//}, _$BasicPropsConfig, initStatics: (statics) {
//  statics
//    ..defaultProps = (statics.newProps()
//      ..basicProp = 'basicProp'
//      ..basic1 = 'basic1'
//    )
//    ..propTypes = {
//      statics.keyFor((p) => p.basicProp): (props, __) {
//        if (props.id == 'id') return PropError.value(props.id, 'id', 'That isn\'t a very descriptive ID.');
//            return null;
//      }
//    };
//});
//
//
//
//
////UiFactory<BasicPropsMixin> Basic2 = (BasicPropsMixin props) {
////  return Dom.div()(
////    Dom.div()('prop id: ${props.id}'),
////    Dom.div()('default prop testing: ${props.basicProp}'),
////    Dom.div()('default prop testing: ${props.basic1}'),
////    Dom.div()(null, props.basic4, 'children: ${props.children}'),
////  );
////}.withTypedProps(_$Basic.factoryFactory);
////
////
////
////UiFactory<BasicPropsMixin> Basic5 = (BasicPropsMixin props) {
////  return Dom.div()(
////    Dom.div()('prop id: ${props.id}'),
////    Dom.div()('default prop testing: ${props.basicProp}'),
////    Dom.div()('default prop testing: ${props.basic1}'),
////    Dom.div()(null, props.basic4, 'children: ${props.children}'),
////  );
////}.asFunctionComponent();
////
////
////UiFactory<BasicPropsMixin> Basic3 = functionBuilder<BasicPropsMixin>().function((props) {
////  return Dom.div()(
////    Dom.div()('prop id: ${props.id}'),
////    Dom.div()('default prop testing: ${props.basicProp}'),
////    Dom.div()('default prop testing: ${props.basic1}'),
////    Dom.div()(null, props.basic4, 'children: ${props.children}'),
////  );
////}.asFunctionComponent();
////
//
//
////extension on ReactDartFunctionComponentFactoryProxy {
////  UiFactory<T> withTypedProps<T extends UiProps>(FunctionFactoryFactory<T> factoryFactory) {
////    return factoryFactory(this);
////  }
////  UiFactory<T> withTypedPropsFromOtherFactory<T extends UiProps>(UiFactory<T> otherFactory) {
////    T uiFactory([Map backingProps]) => otherFactory(backingProps)..componentFactory = this;
////    return uiFactory;
////  }
////}
//
//ReactElement functionComponentContent() {
//  // FIXME look into naming
//  final genericFactory = uiFunctionComponent<UiProps>((props) {
//    debugger();
//    return Dom.div()(
//      Dom.div()('prop id: ${props.id}'),
//    );
//  }, null);
//
////
////
////  UiFactory otherFactory;
////  Object closureVariable;
////
////  final hocFactory = uiFunctionComponent<BasicPropsMixin>((props) {
////    return otherFactory()(
////      Dom.div()('closureVariable: ${closureVariable}'),
////      Dom.div()('prop basic1: ${props.basic1}'),
////    );
////  }, _$basicConfig);
//
//  final basicFactory = uiFunctionComponent<BasicPropsMixin>((props) {
//    return Dom.div()(
//      Dom.div()('prop id: ${props.id}'),
//      Dom.div()('prop basic1: ${props.basic1}'),
//    );
//    // FIXME should displayName really default to "Basic" in this case?
//  }, _$BasicPropsConfig, displayName: 'basicFactory');
//
//  return Fragment()(
//    (genericFactory()..id = '1')(),
//    (basicFactory()..id = '2'..basic1 = 'basic1 value')(),
//    (Basic()..id = '3'..basicProp = 'basicProp')(),
//    (Simple()..basicProp = 'basicProp')(),
//  );
//}
//
//
//UiFactory<T> uiFunctionComponent<T extends UiProps>(
//  dynamic Function(T props) functionComponent,
//  // FIXME allow passing in displayName for generic function components
//  FunctionComponentConfig<T> config,
//{
//    PropsFactory<T> propsFactory,
//  String displayName,
//  void Function(UiFunctionComponentStatics<T>) initStatics,
//}) {
//  if (config != null) {
//    if (propsFactory != null) throw ArgumentError('propsFactory cannot be used along with config');
//    propsFactory = config.propsFactory;
//    displayName ??= config.componentName;
//  }
//
//  // Get the display name from the inner function if possible so it doesn't become `_uiFunctionComponentWrapper`
//  // FIXME make this work in DDC and make more robust
//  displayName ??= getFunctionName(functionComponent);
//
//  dynamic _uiFunctionComponentWrapper(Map props) {
//    return functionComponent(propsFactory.jsMap(props as JsBackedMap));
//  }
//
//  /// FIXME DartFunctionComponent should be JsBackedMap?
//  final factory = react.registerFunctionComponent(_uiFunctionComponentWrapper,
//      displayName: displayName);
//
//  if (propsFactory == null) {
//    // todo allow passing in of custom uiFactory/typedPropsFactory
//    // TODO make it easier to pass in parts of generatedInfo
//    if (T != UiProps && T != GenericUiProps) {
//      throw ArgumentError('config.propsFactory must be provided when using custom props classes');
//    }
//    propsFactory = PropsFactory.fromUiFactory(([backingMap]) => GenericUiProps(factory, backingMap)) as PropsFactory<T>;
//  }
//
//  if (initStatics != null) {
//    final statics = UiFunctionComponentStatics<T>._(
//      newProps: () => propsFactory.jsMap(JsBackedMap()),
//      keyFor: (accessProps) => getPropKey(accessProps, propsFactory.map)
//    );
//    initStatics(statics);
//
//    if (statics.defaultProps != null) {
//      // fixme need to move to react-dart
//      (factory.reactFunction as ReactClass).defaultProps = JsBackedMap.from(statics.defaultProps).jsObject;
//    }
//    // fixme need to implement in react-dart
////    if (statics.propTypes != null) {}
//  }
//
//  T _uiFactory([Map backingMap]) {
//    T builder;
//    if (backingMap == null) {
//      builder = propsFactory.jsMap(JsBackedMap());
//    } else if (backingMap is JsBackedMap) {
//      builder = propsFactory.jsMap(backingMap);
//    } else {
//      builder = propsFactory.map(backingMap);
//    }
//
//    return builder..componentFactory = factory;
//  }
//  return _uiFactory;
//}
//
//String getFunctionName(Function f) {
//  if (f == null) throw ArgumentError.notNull('f');
//
//  // DDC
//  // todo
//
//  // Dart2js
//  final constructor = getProperty(f, 'constructor');
//  if (constructor != null) {
//    return getProperty(constructor, 'name');
//  }
//
//  return null;
//}
//
//class UiFunctionComponentStatics<T> {
//  Map defaultProps;
//  Map<String, react.PropValidator<T>> propTypes;
//
//  final String Function(void Function(T) accessProps) keyFor;
//  final T Function() newProps;
//
//  UiFunctionComponentStatics._({this.keyFor, this.newProps});
////
////  T newProps() => this._newProps();
////
////  String keyFor(void Function(T) accessProps) => this._keyFor(accessProps);
//
//}
//
//class GenericUiProps extends UiProps {
//  @override
//  final Map props;
//
//  GenericUiProps(ReactComponentFactoryProxy componentFactory, [Map props]) :
//        this.props = props ?? JsBackedMap() {
//    this.componentFactory = componentFactory;
//  }
//
//  @override
//  String get propKeyNamespace => '';
//
//  @override
//  bool get $isClassGenerated => true;
//}
//
//typedef FunctionFactoryFactory<T extends UiProps> = UiFactory<T> Function(ReactDartFunctionComponentFactoryProxy);
//
//
//@protected
//class FunctionComponentConfig<T extends UiProps> {
//  @protected
//  final PropsFactory<T> propsFactory;
//  final String componentName;
//
//  @protected
//  FunctionComponentConfig({this.propsFactory, this.componentName});
//}
//
//class PropsFactory<T extends UiProps> {
//  final T Function(Map props) map;
//  final T Function(JsBackedMap props) jsMap;
//
//  PropsFactory({
//    @required this.map,
//    @required this.jsMap,
//  });
//
//  PropsFactory.fromUiFactory(UiFactory<T> factory) : this.map = factory, this.jsMap = factory;
//}
