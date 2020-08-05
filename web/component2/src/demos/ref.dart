import 'dart:html';

import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'ref.over_react.g.dart';

// ------------ `uiForwardRef` with a function component (simple) ------------
mixin UiForwardRefLogsFunctionComponentProps on UiProps {
  BuilderOnlyUiFactory<DomProps> builder;
  Ref<Element> lastClickedButton;
}

final UiForwardRefLogsFunctionComponent = uiForwardRef<UiForwardRefLogsFunctionComponentProps>(
  (props, ref) {
    final prevPropsRef = useRef<UiForwardRefLogsFunctionComponentProps>(null);

    useEffect(() {
      if (prevPropsRef.current != null) {
        print('old props: ${prevPropsRef.current}');
        print('new props: $props');
      }

      prevPropsRef.current = props;
    });

    return ((props.builder()
      ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
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
    final prevPropsRef = useRef<UiForwardRefLogsPropsComplexFunctionComponentProps>(null);

    useEffect(() {
      if (prevPropsRef.current != null) {
        print('old props: ${prevPropsRef.current}');
        print('new props: $props');
      }

      prevPropsRef.current = props;
    });

    return (Fragment()(
      Dom.div()(props.buttonDescription),
      (props.builder()
        ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
        ..ref = ref)(props.children),
    ));
  },
  $UiForwardRefLogsPropsComplexFunctionComponentConfig, // ignore: undefined_identifier
);

// ------------ `uiForwardRef` with a class component (simple) ------------
final UiForwardRefLogsPropsComponent = uiForwardRef<LogPropsProps>(
  (props, ref) {
    return (_LogProps()
      ..addProps(props)
      .._forwardedRef = ref)();
  },
  _LogProps.asForwardRefConfig<LogPropsProps>(displayName: 'UiForwardRefLogsProps'),
);

// ------------ `uiForwardRef` with a class component (complex) ------------
mixin UiForwardRefLogsPropsComplexComponentPropsMixin on UiProps {
  String buttonDescription;
}

class UiForwardRefLogsPropsComplexComponentProps = UiProps
    with UiForwardRefLogsPropsComplexComponentPropsMixin, LogPropsProps;

final UiForwardRefLogsPropsComplexComponent =
    uiForwardRef<UiForwardRefLogsPropsComplexComponentProps>(
  (props, ref) {
    return Fragment()(
      Dom.div()(props.buttonDescription),
      (_LogProps()
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

  // A simple prop to change in order to trigger the print.
  Ref lastClickedButton;

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
    return Dom.div()((props.builder()
      ..modifyProps(addUnconsumedDomProps)
      ..ref = props._forwardedRef)(props.children));
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
    final prevPropsRef = useRef<_LogsPropsFunctionComponentProps>(null);

    useEffect(() {
      if (prevPropsRef.current != null) {
        print('old props: ${prevPropsRef.current}');
        print('new props: $props');
      }

      prevPropsRef.current = props;
    });

    return ((props.builder()
      ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
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
  Dom.button.asForwardRefConfig<DomProps>(displayName: 'FancyButton'),
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

    final lastClickedRef = useState<Ref<Element>>(buttonNodeRefForComplexComponent);

    return ((Dom.div()..style = {'padding': 10})(
      (RefDemoSection()..sectionTitle = 'uiForwardRef Demos')(
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with a function component (simple)')(
          (UiForwardRefLogsFunctionComponent()
            ..builder = FancyButton
            ..lastClickedButton = lastClickedRef.value
            ..id = 'uiForwardRef-function-component'
            ..className = 'btn btn-primary'
            ..ref = buttonNodeRefForSimpleFunctionComponent
            ..onClick = (_) {
              printButtonOuterHtml(buttonNodeRefForSimpleFunctionComponent);
              lastClickedRef.set(buttonNodeRefForSimpleFunctionComponent);
            })(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with a function component (complex)')(
          (UiForwardRefLogsPropsComplexFunctionComponent()
            ..buttonDescription = 'A button that logs the innerHtml'
            ..builder = FancyButton
            ..lastClickedButton = lastClickedRef.value
            ..id = 'uiForwardRef-function-complex-component'
            ..className = 'btn btn-success'
            ..ref = buttonNodeRefForComplexFunctionComponent
            ..onClick = (_) {
              printButtonOuterHtml(buttonNodeRefForComplexFunctionComponent);
              lastClickedRef.set(buttonNodeRefForComplexFunctionComponent);
            })(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with a class component (simple)')(
          (UiForwardRefLogsPropsComponent()
            ..builder = FancyButton
            ..lastClickedButton = lastClickedRef.value
            ..id = 'uiForwardRef-component'
            ..className = 'btn btn-warning'
            ..ref = buttonNodeRefForSimpleComponent
            ..onClick = (_) {
              printButtonOuterHtml(buttonNodeRefForSimpleComponent);
              lastClickedRef.set(buttonNodeRefForSimpleComponent);
            })(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with a class component (complex)')(
          (UiForwardRefLogsPropsComplexComponent()
            ..buttonDescription = 'A button that logs the innerHtml'
            ..builder = FancyButton
            ..lastClickedButton = lastClickedRef.value
            ..id = 'uiForwardRef-complex-component'
            ..className = 'btn btn-danger'
            ..ref = buttonNodeRefForComplexComponent
            ..onClick = (_) {
              printButtonOuterHtml(buttonNodeRefForComplexComponent);
              lastClickedRef.set(buttonNodeRefForComplexComponent);
            })(),
        ),
      ),
      (RefDemoSection()..sectionTitle = 'forwardRef (deprecated) Demos')(
        (RefDemoHoc()..demoTitle = '`forwardRef` with class component')(
          (LogProps()
            ..builder = FancyButton
            ..lastClickedButton = lastClickedRef.value
            ..id = 'forwardRef-component'
            ..className = 'btn btn-primary'
            ..ref = fancyButtonNodeRef
            ..onClick = (_) {
              printButtonOuterHtml(fancyButtonNodeRef);
              lastClickedRef.set(fancyButtonNodeRef);
            })(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with function component')(
          (LogsPropsFunctionComponent()
            ..builder = FancyButton
            ..lastClickedButton = lastClickedRef.value
            ..id = 'forwardRef-function-component'
            ..className = 'btn btn-success'
            ..ref = fancyFunctionalButtonNodeRef
            ..onClick = (_) {
              printButtonOuterHtml(fancyFunctionalButtonNodeRef);
              lastClickedRef.set(fancyFunctionalButtonNodeRef);
            })(),
        ),
      ),
    ));
  },
  $RefDemoContainerConfig, // ignore: undefined_identifier
);

void printButtonOuterHtml(Ref buttonRef) {
  print('this button outerHTML: ${buttonRef.current.outerHtml}');
}

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
