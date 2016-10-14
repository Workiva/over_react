library test_util.test_js_component;

import 'package:js/js.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:react/react_client/react_interop.dart';

/// A factory for a JS composite component.
final Function testJsComponentFactory = (() {
  var componentClass = React.createClass(new ReactClassConfig(
    displayName: 'testJsComponent',
    render: allowInterop(() => react.div({}, 'test js component'))
  ));

  var reactFactory = React.createFactory(componentClass);

  return ([props = const {}, children]) {
    return reactFactory(jsify(props), listifyChildren(children));
  };
})();
