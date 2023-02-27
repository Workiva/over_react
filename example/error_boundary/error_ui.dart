// Copyright 2022 Workiva Inc.
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

import 'package:over_react/components.dart';
import 'package:over_react/over_react.dart' hide ErrorBoundary;

part 'error_ui.over_react.g.dart';

UiFactory<ErrorUiProps> ErrorUi =
    castUiFactory(_$ErrorUi); // ignore: undefined_identifier

mixin ErrorUiProps on UiProps {}

mixin ErrorUiState on UiState {
  bool? triggerError;
  String? stack;
}

class ErrorUiComponent
    extends UiStatefulComponent2<ErrorUiProps, ErrorUiState> {
  @override
  get initialState => (newState()..triggerError = false);

  @override
  render() {
    final triggerError = state.triggerError!;
    final stack = state.stack;

    return (Dom.div()
      ..style = {
        'margin': 16,
        'paddingBottom': 16,
        'borderBottom': '1px solid grey'
      }
    )(
      (Dom.div()
        ..style = {
          'height': 300,
        }
      )(
        (ErrorBoundary()
          ..onComponentDidCatch = (e, i) {
            if (state.stack == null) {
              setState(newState()..stack = i.componentStack);
            }

            print(i.componentStack);
          }
        )(
          triggerError ? (ThrowingComponent()()) : null,
        ),
      ),
      Dom.div()(
        (Dom.button()
          ..onClick = ((_) => setState(newState()..triggerError = true))
          ..disabled = triggerError
          ..style = {
            'margin': '0 5px 0 5px',
          }
        )('Trigger Error'),
        (Dom.button()
          ..onClick = ((_) => setState(newState()
            ..triggerError = false
            ..stack = null
          ))
          ..disabled = !triggerError
          ..style = {
            'margin': '0 5px 0 5px',
          }
        )('Reset'),
      ),
      stack != null
          ? (Dom.div()
            ..style = {
              'border': '1px solid black',
              'margin': 8,
              'padding': 8,
            }
          )(
              (Dom.div()
                ..style = {
                  'padding': 4,
                  'borderBottom': '1px solid grey',
                  'display': 'flex',
                  'justifyContent': 'space-between',
                }
              )(
                Dom.div()('Stack'),
                Dom.div()(
                  stack.contains('ThrowingComponent')
                      ? 'Detected ThrowingComponent ✅'
                      : 'Failed to Find ThrowingComponent ❌',
                ),
              ),
              (Dom.div()
                ..addProp('dangerouslySetInnerHTML', {
                  '__html': stack
                      .replaceAll('ThrowingComponent',
                          '<span style="color: green">ThrowingComponent</span>')
                      .replaceAll('at', '<br /><br />at')
                })
              )(),
            )
          : null,
    );
  }
}

UiFactory<ThrowingComponentProps> ThrowingComponent =
    castUiFactory(_$ThrowingComponent); // ignore: undefined_identifier

mixin ThrowingComponentProps on UiProps {}

class ThrowingComponentComponent extends UiComponent2<ThrowingComponentProps> {
  @override
  render() {
    throw StateError('Oh Dang');
  }
}
