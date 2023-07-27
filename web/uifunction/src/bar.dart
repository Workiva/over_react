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

import 'baz.dart';
import 'button.dart';
import 'component_wrapper.dart';
import 'utils.dart';

part 'bar.over_react.g.dart';

mixin BarPropsMixin on UiProps {
  String bar;

  @Accessor(key:'data-is-fancy', keyNamespace: '')
  bool isFancy;
}

const excludePropsMixins = {BarPropsMixin};

final BarDemo = createVisualComponent(Bar, excludedMixins: excludePropsMixins);


final Bar = uiFunction<BarPropsMixin>((props) {
  final randomState = useState(true);
  return Dom.div()(
    (Button()..onClick = (e) => randomState.set(!randomState.value))('UPDATE STATE'),
    (BazDemo()
      ..addAll(props.getPropsToForward(exclude: excludePropsMixins))
    )(),
    (DomDivDemo()
      ..modifyProps(props.addPropsToForward(exclude: {}, domOnly: true))
    )('This div should have a `data-is-fancy` attribute!'),
  );
}, _$BarConfig);
