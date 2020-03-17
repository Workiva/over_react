// Copyright 2019 Workiva Inc.
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

// ignore: uri_has_not_been_generated
part 'dummy_component.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<DummyProps> Dummy = _$Dummy;

mixin DummyProps on UiProps {
  Function onComponentDidMount;
}

class DummyComponent extends UiComponent2<DummyProps> {
  @override
  void componentDidMount() {
    props.onComponentDidMount();
  }

  @override
  render() {
    return (Dom.button()..addTestId('DummyButton'))('oh hai');
  }
}
