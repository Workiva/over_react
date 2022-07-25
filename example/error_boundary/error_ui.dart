import 'package:over_react/components.dart';
import 'package:over_react/over_react.dart' hide ErrorBoundary;

part 'error_ui.over_react.g.dart';

UiFactory<ErrorUiProps> ErrorUi =
    castUiFactory(_$ErrorUi); // ignore: undefined_identifier

mixin ErrorUiProps on UiProps {}

mixin ErrorUiState on UiState {
  bool triggerError;
  String stack;
}

class ErrorUiComponent
    extends UiStatefulComponent2<ErrorUiProps, ErrorUiState> {
  @override
  get initialState => (newState()..triggerError = false);

  @override
  render() {
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
          state.triggerError ? (ThrowingComponent()()) : null,
        ),
      ),
      Dom.div()(
        (Dom.button()
          ..onClick = ((_) => setState(newState()..triggerError = true))
          ..disabled = state.triggerError
          ..style = {
            'margin': '0 5px 0 5px',
          }
        )('Trigger Error'),
        (Dom.button()
          ..onClick = ((_) => setState(newState()
            ..triggerError = false
            ..stack = null
          ))
          ..disabled = !state.triggerError
          ..style = {
            'margin': '0 5px 0 5px',
          }
        )('Reset'),
      ),
      state.stack != null
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
                  state.stack.contains('ThrowingComponentComponent')
                      ? 'Detected ThrowingComponentComponent ✅'
                      : 'Failed to Find ThrowingComponentComponent ❌',
                ),
              ),
              (Dom.div()
                ..addProp('dangerouslySetInnerHTML', {
                  '__html': state.stack
                      .replaceAll('ThrowingComponentComponent',
                          '<span style="color: green">ThrowingComponentComponent</span>')
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
