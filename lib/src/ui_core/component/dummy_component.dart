library dummy_component;

import 'package:react/react.dart' as react;

/// Dummy component to be used when needing to type check a sub component of an abstract super component.
class DummyComponent extends react.Component {
  @override
  render() {}
}
