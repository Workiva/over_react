import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'forward_ref.over_react.g.dart';

final FancyButton = forwardRef<DomProps>((props, ref) {
  final classes = ClassNameBuilder.fromProps(props)
    ..add('FancyButton');

  return (Dom.button()
    ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
    ..className = classes.toClassName()
    ..ref = ref
  )('Click me!');
}, displayName: 'FancyButton')(Dom.button);

final LogProps = forwardRef<LogPropsProps>((props, ref) {
  return (_LogProps()
    ..addProps(props)
    .._forwardedRef = ref
  )('Click me!');
}, displayName: 'LogProps')(_LogProps);

@Factory()
UiFactory<LogPropsProps> _LogProps = _$_LogProps;

@Props()
class _$LogPropsProps extends UiProps {
  BuilderOnlyUiFactory<DomProps> builder;

  // Private since we only use this to pass along the value of `ref` to
  // the return value of forwardRef.
  //
  // Consumers can set this private field value using the public `ref` setter.
  Ref _forwardedRef;
}

@Component2()
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
      ..ref = props._forwardedRef
    )(props.children);
  }
}