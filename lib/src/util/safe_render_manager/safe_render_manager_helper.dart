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

import 'package:over_react/src/component/dom_components.dart';
import 'package:over_react/src/util/react_wrappers.dart';

import 'package:over_react/src/component_declaration/component_declaration.dart';

part 'safe_render_manager_helper.over_react.g.dart';

/// A component that allows for safe unmounting of its single child by waiting for state changes
/// sometimes queued by ReactJS to be applied.
UiFactory<SafeRenderManagerHelperProps> SafeRenderManagerHelper =
    // ignore: undefined_identifier
    castUiFactory(_$SafeRenderManagerHelper);

mixin SafeRenderManagerHelperProps on UiProps {
  @requiredProp
  ReactElement? Function()? getInitialContent;

  dynamic contentRef;
}

mixin SafeRenderManagerHelperState on UiState {
  ReactElement? content;
}

@Component2()
class SafeRenderManagerHelperComponent extends UiStatefulComponent2<SafeRenderManagerHelperProps, SafeRenderManagerHelperState> {
  @override
  get initialState => (newState()..content = props.getInitialContent!());

  void renderContent(ReactElement? content) {
    setState(newState()..content = content);
  }

  void tryUnmountContent({void Function(bool isUnmounted)? onMaybeUnmounted}) {
    setState(newState()..content = null, () {
      onMaybeUnmounted?.call(state.content == null);
    });
  }

  bool get hasContent => state.content != null;

  @override
  render() {
    final content = state.content;
    if (content == null) return null;

    return cloneElement(content, domProps()..ref = chainRefs(content.ref, props.contentRef));
  }
}
