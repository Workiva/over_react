library dummy_component;

import 'package:react/react.dart' as react;

/// Dummy component useful for:
///
/// - Allowing sub-typing of components.
class DummyComponent extends react.Component {
  @override
  render() => false;
}
