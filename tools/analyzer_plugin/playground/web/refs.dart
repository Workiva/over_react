import 'package:over_react/over_react.dart';

part 'refs.over_react.g.dart';

UiFactory<HasNoRefsProps> HasNoRefs = _$HasNoRefs; // ignore: undefined_identifier

mixin HasNoRefsProps on UiProps {}

class HasNoRefsComponent extends UiComponent2<HasNoRefsProps> {
  @override
  render() {
    return Child()(props.children);
  }
}

UiFactory<UsesStringRefProps> UsesStringRef = _$UsesStringRef; // ignore: undefined_identifier

mixin UsesStringRefProps on UiProps {}

class UsesStringRefComponent extends UiComponent2<UsesStringRefProps> {
  @override
  render() {
    return (Child()
      ..ref = 'child'
    )(props.children);
  }

  get stringRefAccess => ref('child');
}

UiFactory<UsesCallbackRefProps> UsesCallbackRef = _$UsesCallbackRef; // ignore: undefined_identifier

mixin UsesCallbackRefProps on UiProps {}

class UsesCallbackRefComponent extends UiComponent2<UsesCallbackRefProps> {
  ChildComponent _someCustomRefName;

  @override
  render() {
    return (Child()
      ..ref = (ref) { _someCustomRefName = ref; }
    )(props.children);
  }

  void foo() {
    _someCustomRefName.someMethodName();
    _someCustomRefName?.anotherMethodName();
    final bar = _someCustomRefName.someGetter;
  }
}

UiFactory<ChildProps> Child = _$Child; // ignore: undefined_identifier

mixin ChildProps on UiProps {}

class ChildComponent extends UiComponent2<ChildProps> {
  @override
  render() {}

  void someMethodName() {}

  void anotherMethodName() {}

  bool get someGetter => false;
}