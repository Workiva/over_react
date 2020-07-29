import 'dart:html';

import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'forward_ref.over_react.g.dart';

// ------------ `uiForwardRef` with a function component (simple) ------------
mixin UiForwardRefLogsFunctionComponentProps on UiProps {
  BuilderOnlyUiFactory<DomProps> builder;

  // Private since we only use this to pass along the value of `ref` to
  // the return value of forwardRef.
  //
  // Consumers can set this private field value using the public `ref` setter.
  Ref _forwardedRef;
}

final UiForwardRefLogsFunctionComponent = uiForwardRef<UiForwardRefLogsFunctionComponentProps>(
  (props, ref) {
    return ((props.builder()
      ..id = props.id
      ..className = props.className
      ..onClick = props.onClick
      ..ref = ref)(props.children));
  },
  $UiForwardRefLogsFunctionComponentConfig, // ignore: undefined_identifier
);

// ------------ `uiForwardRef` with a function component (complex) ------------
mixin UiForwardRefLogsPropsComplexFunctionComponentPropsMixin on UiProps {
  String buttonDescription;
}

class UiForwardRefLogsPropsComplexFunctionComponentProps = UiProps
    with
        UiForwardRefLogsPropsComplexFunctionComponentPropsMixin,
        UiForwardRefLogsFunctionComponentProps;

final UiForwardRefLogsPropsComplexFunctionComponent =
    uiForwardRef<UiForwardRefLogsPropsComplexFunctionComponentProps>(
  (props, ref) {
    return (Fragment()(
      Dom.div()(props.buttonDescription),
      (props.builder()
        ..id = props.id
        ..className = props.className
        ..onClick = props.onClick
        ..ref = ref)(props.children),
    ));
  },
  $UiForwardRefLogsPropsComplexFunctionComponentConfig, // ignore: undefined_identifier
);

// ------------ `uiForwardRef` with a class component (simple) ------------
final UiForwardRefLogsPropsComponent = uiForwardRef<LogPropsProps>(
  (props, ref) {
    return (_LogsPropsFunctionComponent()
      ..addProps(props)
      .._forwardedRef = ref)();
  },
  FunctionComponentConfig(
      propsFactory: PropsFactory.fromUiFactory(_LogsPropsFunctionComponent), displayName: null),
);

// ------------ `uiForwardRef` with a class component (complex) ------------
mixin UiForwardRefLogsPropsComplexComponentPropsMixin on UiProps {
  String buttonDescription;
}

class UiForwardRefLogsPropsComplexComponentProps = UiProps
    with UiForwardRefLogsPropsComplexFunctionComponentPropsMixin, LogPropsProps;

final UiForwardRefLogsPropsComplexComponent =
    uiForwardRef<UiForwardRefLogsPropsComplexComponentProps>(
  (props, ref) {
    return Fragment()(
      Dom.div()(props.buttonDescription),
      (_LogsPropsFunctionComponent()
        ..addProps(props)
        .._forwardedRef = ref)(),
    );
  },
  $UiForwardRefLogsPropsComplexComponentConfig, // ignore: undefined_identifier
);

// ------------ `forwardRef` (deprecated) with class component ------------
final LogProps = forwardRef<LogPropsProps>((props, ref) {
  return (_LogProps()
    ..addProps(props)
    .._forwardedRef = ref)();
}, displayName: 'LogProps')(_LogProps);

UiFactory<LogPropsProps> _LogProps = _$_LogProps;

mixin LogPropsProps on UiProps {
  BuilderOnlyUiFactory<DomProps> builder;

  // Private since we only use this to pass along the value of `ref` to
  // the return value of forwardRef.
  //
  // Consumers can set this private field value using the public `ref` setter.
  Ref _forwardedRef;
}

class LogPropsComponent extends UiComponent2<LogPropsProps> {
  @override
  void componentDidUpdate(Map prevProps, _, [__]) {
    print('old props: $prevProps');
    print('new props: $props');
  }

  @override
  render() {
    return (props.builder()
      ..modifyProps(addUnconsumedDomProps)
      ..ref = props._forwardedRef)(props.children);
  }
}

// ------------ `forwardRef` (deprecated) with Function component ------------
final LogsPropsFunctionComponent = forwardRef<_LogsPropsFunctionComponentProps>((props, ref) {
  return (_LogsPropsFunctionComponent()
    ..addProps(props)
    .._forwardedRef = ref)();
}, displayName: 'LogsPropsFunctionComponent')(_LogsPropsFunctionComponent);

class _LogsPropsFunctionComponentProps = UiProps with LogPropsProps;

final _LogsPropsFunctionComponent = uiFunction<_LogsPropsFunctionComponentProps>(
  (props) {
    return ((props.builder()
      ..id = props.id
      ..className = props.className
      ..onClick = props.onClick
      ..ref = props._forwardedRef)(props.children));
  },
  $_LogsPropsFunctionComponentConfig, // ignore: undefined_identifier
);

// -------------------------------- Demo Display Logic --------------------------------
final FancyButton = uiForwardRef<DomProps>(
  (props, ref) {
    final classes = ClassNameBuilder.fromProps(props)..add('FancyButton');

    return (Dom.button()
      ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
      ..className = classes.toClassName()
      ..ref = ref)('Click me!');
  },
  FunctionComponentConfig(propsFactory: PropsFactory.fromUiFactory(Dom.button), displayName: null),
);

mixin RefDemoProps on UiProps {}

final RefDemoContainer = uiFunction<RefDemoProps>(
  (props) {
    // `uiForwardRef` Refs
    final buttonNodeRefForSimpleFunctionComponent = createRef<Element>();
    final buttonNodeRefForComplexFunctionComponent = createRef<Element>();
    final buttonNodeRefForSimpleComponent = createRef<Element>();
    final buttonNodeRefForComplexComponent = createRef<Element>();

    // `forwardRef` Refs
    final fancyButtonNodeRef = createRef<Element>();
    final fancyFunctionalButtonNodeRef = createRef<Element>();

    return ((Dom.div()..style = {'padding': 10})(
      (RefDemoSection()..sectionTitle = 'uiForwardRef Demos')(
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with a function component (simple)')(
          (UiForwardRefLogsFunctionComponent()
            ..builder = FancyButton
            ..id = 'uiForwardRef-function-component'
            ..className = 'btn btn-primary'
            ..ref = buttonNodeRefForSimpleFunctionComponent
            ..onClick = (_) {
              print(buttonNodeRefForSimpleFunctionComponent.current.outerHtml);
            })(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with a function component (complex)')(
          (UiForwardRefLogsPropsComplexFunctionComponent()
            ..buttonDescription = 'A button that logs the innerHtml'
            ..builder = FancyButton
            ..id = 'uiForwardRef-function-complex-component'
            ..className = 'btn btn-success'
            ..ref = buttonNodeRefForComplexFunctionComponent
            ..onClick = (_) {
              print(buttonNodeRefForComplexFunctionComponent.current.outerHtml);
            })(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with a class component (simple)')(
          (UiForwardRefLogsPropsComponent()
            ..builder = FancyButton
            ..id = 'uiForwardRef-component'
            ..className = 'btn btn-warning'
            ..ref = buttonNodeRefForSimpleComponent
            ..onClick = (_) {
              print(buttonNodeRefForSimpleComponent.current.outerHtml);
            })(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with a class component (complex)')(
          (UiForwardRefLogsPropsComplexComponent()
            ..buttonDescription = 'A button that logs the innerHtml'
            ..builder = FancyButton
            ..id = 'uiForwardRef-complex-component'
            ..className = 'btn btn-danger'
            ..ref = buttonNodeRefForComplexComponent
            ..onClick = (_) {
              print(buttonNodeRefForComplexComponent.current.outerHtml);
            })(),
        ),
      ),
      (RefDemoSection()..sectionTitle = 'forwardRef (deprecated) Demos')(
        (RefDemoHoc()..demoTitle = '`forwardRef` with class component')(
          (LogProps()
            ..builder = FancyButton
            ..id = 'forwardRef-component'
            ..className = 'btn btn-primary'
            ..ref = fancyButtonNodeRef
            ..onClick = (_) {
              print(fancyButtonNodeRef.current.outerHtml);
            })(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with function component')(
          (LogsPropsFunctionComponent()
            ..builder = FancyButton
            ..id = 'forwardRef-function-component'
            ..className = 'btn btn-success'
            ..ref = fancyFunctionalButtonNodeRef
            ..onClick = (_) {
              print(fancyFunctionalButtonNodeRef.current.outerHtml);
            })(),
        ),
      ),
    ));
  },
  $RefDemoContainerConfig, // ignore: undefined_identifier
);

mixin RefDemoSectionProps on UiProps {
  String sectionTitle;
}

final RefDemoSection = uiFunction<RefDemoSectionProps>(
  (props) {
    return (Fragment()(
        (Dom.h3()..style = {'color': 'gray', 'borderBottom': '1px solid gray', 'marginTop': 10})(
          props.sectionTitle,
        ),
        (Dom.div()
          ..style = {
            'display': 'flex',
            'flexWrap': 'wrap',
          })(
          props.children,
        )));
  },
  $RefDemoSectionConfig, // ignore: undefined_identifier
);

mixin RefDemoHocProps on UiProps {
  String demoTitle;
}

final RefDemoHoc = uiFunction<RefDemoHocProps>(
  (props) {
    return ((Dom.div()..style = {'flex': '0 50%', 'width': '100%', 'marginTop': 10})(
      Dom.h4()(props.demoTitle),
      props.children,
    ));
  },
  $RefDemoHocConfig, // ignore: undefined_identifier
);
