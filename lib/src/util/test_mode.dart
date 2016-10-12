library over_react.test_mode;

import 'package:over_react/src/over_react/component_declaration/component_base.dart' as component_base;

/// Enables test mode.
///
/// This allows `testId`s, set via [component_base.UiProps.addTestId], to be rendered.
void enableTestMode() {
  component_base.UiProps.testMode = true;
}

/// Disables test mode.
///
/// This prevents `testId`s, set via [component_base.UiProps.addTestId], from being rendered.
void disableTestMode() {
  component_base.UiProps.testMode = false;
}
