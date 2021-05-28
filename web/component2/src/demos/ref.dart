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
  _$FancyButtonConfig, // ignore: undefined_identifier
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

      // Needs to be split up due to https://github.com/dart-lang/sdk/issues/42975
      final builder = factoryToWrap()
        ..addAll(props)
        ..ref = ref;
       return builder(props.children);
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
UiFactory<FooProps> _Foo = castUiFactory(_$_Foo); // ignore: undefined_identifier

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
  _$Foo2Config, // ignore: undefined_identifier
);
