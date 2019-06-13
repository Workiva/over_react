import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart' as builder_helpers;
import 'package:react/react_client.dart' as rc;
import 'package:react/src/react_client/js_backed_map.dart';

class FragmentProps extends component_base.UiProps
    with
        builder_helpers.GeneratedClass
    implements
        builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  FragmentProps(this.componentFactory, [Map props]) : this.props = props ?? new JsBackedMap();

  @override
  final rc.ReactJsComponentFactoryProxy componentFactory;

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';
}

Fragment() => new FragmentProps(rc.Fragment);