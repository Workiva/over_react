// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'functional_consumed_props.over_react.g.dart';

mixin ParentOnlyPropsMixin on UiProps {
  String aParentProp;
}

mixin SharedPropsMixin on UiProps {
  String aPropToBePassed;
}

class SomeParentProps = UiProps with ParentOnlyPropsMixin, SharedPropsMixin;

UiFactory<SomeParentProps> SomeParent = uiFunction((props) {
    final consumedProps = props.staticMeta.forMixins({ParentOnlyPropsMixin});

    return (
        Dom.div()(
          Dom.div()(
            'The parent prop is: ${props.aParentProp}',
          ),
          (SomeChild()..addUnconsumedProps(props, consumedProps))(),
        )
    );
  },
  _$SomeParentConfig, // ignore: undefined_identifier
);

class SomeChildProps = UiProps with SharedPropsMixin;

UiFactory<SomeChildProps> SomeChild = uiFunction((props) {
  return (
    Fragment()(
      'The passed prop value is ${props.aPropToBePassed}',
    )
  );
},
  _$SomeChildConfig, // ignore: undefined_identifier
);
