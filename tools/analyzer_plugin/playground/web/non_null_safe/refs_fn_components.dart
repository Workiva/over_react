// @dart=2.11
// This file is a non-null safe copy of playground examples to enable QAing backwards compatibility.
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
    ChildComponent _customRefAssignedInTearoff;

    void _tearOffRefAssignment(ChildComponent ref) {
      _customRefAssignedInTearoff = ref;
    }

    void foo() {
      _someCustomRefName.someMethodName();
      _someCustomRefName?.anotherMethodName();
      final bar = _someCustomRefName.someGetter;

      _anotherCustomRefName.someMethodName();
      _anotherCustomRefName?.anotherMethodName();
      final baz = _anotherCustomRefName.someGetter;

      _customRefAssignedInTearoff.someMethodName();
      _customRefAssignedInTearoff?.anotherMethodName();
      final biz = _customRefAssignedInTearoff.someGetter;
    }

    return Fragment()(
      (Child()
        ..ref = (ref) {
          _someCustomRefName = ref;
        }
      )(props.children),
      (Child()
        ..id = 'bar'
        ..ref = ((ref) => _anotherCustomRefName = ref)
      )('hi'),
      (Child()
        ..id = 'biz'
        ..ref = _tearOffRefAssignment
      )('yo'),
      (Child())('there'),
    );
  },
  UiFactoryConfig(displayName: 'UsesCallbackRef'),
);
