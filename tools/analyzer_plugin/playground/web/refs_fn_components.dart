import 'package:over_react/over_react.dart';

import 'refs.dart';

final HasNoRefs = uiFunction<UiProps>(
  (props) {
    return Child()(props.children);
  },
  UiFactoryConfig(displayName: 'HasNoRefs'),
);

final UsesCallbackRef = uiFunction<UiProps>(
  (props) {
    ChildComponent _someCustomRefName;
    ChildComponent _anotherCustomRefName;

    void foo() {
      _someCustomRefName.someMethodName();
      _someCustomRefName?.anotherMethodName();
      final bar = _someCustomRefName.someGetter;

      _anotherCustomRefName.someMethodName();
      _anotherCustomRefName?.anotherMethodName();
      final baz = _anotherCustomRefName.someGetter;
    }

    return Fragment()(
      (Child()
        ..ref = _someCustomRefName)(props.children),
      (Child()
        ..id = 'bar'
        ..ref = ((ref) => _anotherCustomRefName = ref)
      )('hi'),
      (Child())('there'),
    );
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
