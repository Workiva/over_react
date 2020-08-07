// ignore_for_file: deprecated_member_use_from_same_package
import 'dart:html';

import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'ref.over_react.g.dart';

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//                          UiForwardRef Examples
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// ### Example 1: Updating a function component to forward a ref:
//----------------------------------------------------------------------------//
mixin FancyButtonProps on UiProps {}

UiFactory<FancyButtonProps> FancyButton = uiForwardRef(
  (props, ref) {
    final classes = ClassNameBuilder.fromProps(props)..add('FancyButton');
    return (Dom.button()
      ..ref = ref
      ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
      ..className = classes.toClassName()
    )('Click me!');
  },
  $FancyButtonConfig, // ignore: undefined_identifier
);

//----------------------------------------------------------------------------//
// ### Example 2: Creating a higher-order component (https://reactjs.org/docs/higher-order-components.html)
// that forwards its ref to the wrapped component.
//----------------------------------------------------------------------------//

/// Wraps a component ([factoryToWrap]) in a new component that logs when rendered.
UiFactory<TProps> withLogging<TProps extends UiProps>(UiFactory<TProps> factoryToWrap) {
  return uiForwardRef(
    (props, ref) {
      useEffect(() => 'withLogging rendered!');

      // This requires an ignore until https://github.com/dart-lang/sdk/issues/42975
      // is fixed.
      return (factoryToWrap() // ignore: invocation_of_non_function_expression
        ..addAll(props)
        ..ref = ref
      )(props.children);
    },
    factoryToWrap.asForwardRefConfig(
      displayName: 'WithLogging',
    ),
  );
}

/// This can be used just like FancyButton, and setting a ref on it will work the same!
UiFactory<FancyButtonProps> FancyButtonWithLogging = withLogging(FancyButton);

//----------------------------------------------------------------------------//
// ### Example 3: Exposing inner refs in class components
//----------------------------------------------------------------------------//
UiFactory<FooProps> _Foo = _$_Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {
  // Private since we only use this to pass along the ref provided in
  // uiForwardRef.
  //
  // Consumers will effectively be setting this when they set `ref` on the public factory.
  dynamic _inputRef;
}

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() {
    return Dom.div()(
      (Dom.input()
        ..modifyProps(addUnconsumedDomProps)
        ..type = 'text'
        ..ref = props._inputRef
      )(),
    );
  }
}

// Option 1: Use the class component's factory as the UiFactoryConfig arg.
UiFactory<FooProps> Foo = uiForwardRef(
  (props, ref) {
    return (_Foo()
      ..addProps(props)
      .._inputRef = ref
    )();
  },
  // Note that `displayName` is not passed in here.
  // In the React devtools, the name of `Foo` will be
  // 'Anonymous'. 
  _Foo.asForwardRefConfig(),
);

// Option 2: Create a new props class.
mixin AnotherPropsMixin on UiProps {
  String anExampleAdditionalProp;
}

class Foo2Props = UiProps with AnotherPropsMixin, FooProps;

final Foo2 = uiForwardRef<Foo2Props>(
  (props, ref) {
    print(props.anExampleAdditionalProp);
    return (_Foo()
      ..addProps(props)
      .._inputRef = ref
    )();
  },
  $Foo2Config, // ignore: undefined_identifier
);

//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//
//                      forwardRef Examples (deprecated)
//----------------------------------------------------------------------------//
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// ### Example 1: Exposing inner refs in class components:
//----------------------------------------------------------------------------//
UiFactory<LogProps> LogPropsHoc = forwardRef<LogProps>((props, ref) {
  return (_Log()
    ..addProps(props)
    .._forwardedRef = ref
  )();
}, displayName: 'LogProps')(_Log);

UiFactory<LogProps> _Log = _$_Log; // ignore: undefined_identifier

mixin LogProps on UiProps {
  BuilderOnlyUiFactory<UiProps> builder;

  // Private since we only use this to pass along the value of `ref` to
  // the return value of forwardRef.
  //
  // Consumers can set this private field value using the public `ref` setter.
  dynamic _forwardedRef;
}

class _LogComponent extends UiComponent2<LogProps> {
  @override
  void componentDidUpdate(Map prevProps, _, [__]) {
    print('old props: $prevProps');
    print('new props: $props');
  }

  @override
  render() {
    return Dom.div()(
      (props.builder()
        ..modifyProps(addUnconsumedDomProps)
        ..ref = props._forwardedRef
      )(props.children),
    );
  }
}

//----------------------------------------------------------------------------//
// ### Example 2: Exposing inner refs in functional components:
//----------------------------------------------------------------------------//
UiFactory<BazProps> LoggingFunctionWrapper = forwardRef<BazProps>((props, ref) {
  print('LoggingFunctionWrapper rendered!');

  return (Baz()
    ..addProps(props)
    ..builder = props.builder
    .._forwardedRef = ref
  )();
}, displayName: 'LoggingFunctionWrapper')(Baz);

mixin BazProps on UiProps {
  BuilderOnlyUiFactory<UiProps> builder;

  // Private since we only use this to pass along the value of `ref` to
  // the return value of forwardRef.
  //
  // Consumers can set this private field value using the public `ref` setter.
  dynamic _forwardedRef;
}

final Baz = uiFunction<BazProps>(
  (props) {
    return ((props.builder()
      ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
      ..ref = props._forwardedRef
    )(props.children));
  },
  $BazConfig, // ignore: undefined_identifier
);

// -------------------------------- Demo Display Logic --------------------------------

mixin RefDemoProps on UiProps {}

UiFactory<RefDemoProps> RefDemoContainer = uiFunction(
  (props) {
    // `uiForwardRef` Refs
    final fancyButtonUiForwardRef = createRef<Element>();
    final fancyButtonWithLoggingReg = createRef<Element>();
    final fooInputRef = createRef<Element>();
    final foo2InputRef = createRef<Element>();

    // `forwardRef` Refs
    final fancyButtonNodeRef = createRef<Element>();
    final fancyFunctionalButtonNodeRef = createRef<Element>();

    return ((Dom.div()..style = {'padding': 10})(
      (RefDemoSection()..sectionTitle = 'uiForwardRef Demos')(
        (RefDemoHoc()..demoTitle = 'Basic `uiForwardRef`')(
          (FancyButton()
            ..className = 'btn btn-primary'
            ..ref = fancyButtonUiForwardRef
            ..onClick = (_) => printButtonOuterHtml(fancyButtonUiForwardRef)
          )(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` wrapped in HOC')(
          (FancyButtonWithLogging()
            ..className = 'btn btn-success'
            ..ref = fancyButtonWithLoggingReg
            ..onClick = (_) => printButtonOuterHtml(fancyButtonUiForwardRef)
          )(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` wrapping a class (option 1)')(
          (Foo()
            ..ref = fooInputRef
            ..onChange = (e) => print('Foo Input Ref: ${e.target.value}')
          )(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` wrapping a class (option 2)')(
          (Foo2()
            ..anExampleAdditionalProp = 'This additional prop logs on renders!'
            ..ref = foo2InputRef
            ..onChange = (e) => print('Foo2 Input Ref: ${e.target.value}')
          )(),
        ),
      ),
      (RefDemoSection()..sectionTitle = 'forwardRef (deprecated) Demos')(
        (RefDemoHoc()..demoTitle = '`forwardRef` with class component')(
          (LogPropsHoc()
            ..builder = FancyButton
            ..ref = fancyButtonNodeRef
            ..className = 'btn btn-primary'
            ..onClick = (_) => printButtonOuterHtml(fancyButtonNodeRef)
          )(),
        ),
        (RefDemoHoc()..demoTitle = '`uiForwardRef` with function component')(
          (LoggingFunctionWrapper()
            ..builder = FancyButton
            ..className = 'btn btn-success'
            ..ref = fancyFunctionalButtonNodeRef
            ..onClick = (_) {
              printButtonOuterHtml(fancyFunctionalButtonNodeRef);
            }
          )(),
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

UiFactory<RefDemoSectionProps> RefDemoSection = uiFunction(
  (props) {
    return (Fragment()(
      (Dom.h3()..style = {'color': 'gray', 'borderBottom': '1px solid gray', 'marginTop': 10})(
        props.sectionTitle,
      ),
      (Dom.div()
        ..style = {
          'display': 'flex',
          'flexWrap': 'wrap',
        }
      )(
        props.children,
      ),
    ));
  },
  $RefDemoSectionConfig, // ignore: undefined_identifier
);

mixin RefDemoHocProps on UiProps {
  String demoTitle;
}

UiFactory<RefDemoHocProps> RefDemoHoc = uiFunction(
  (props) {
    return ((Dom.div()..style = {'flex': '0 50%', 'width': '100%', 'marginTop': 10})(
      Dom.h4()(props.demoTitle),
      props.children,
    ));
  },
  $RefDemoHocConfig, // ignore: undefined_identifier
);
