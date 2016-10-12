library over_react.prop_typedefs;

import 'package:react/react_client.dart';
import 'package:over_react/src/over_react/component_declaration/component_base.dart' as component_base;
import 'package:over_react/over_react.dart';

/// A typedef for props that allow a custom rendering function to be provided to render some part of a component.
typedef ReactElement CustomRenderFunction<TProps extends UiProps, TState extends UiState, TComponent extends component_base.UiComponent> (TProps props, TState state, TComponent component);
