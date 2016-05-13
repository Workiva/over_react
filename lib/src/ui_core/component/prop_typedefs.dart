library ui_core.prop_typedefs;

import 'package:react/react_client.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/component_base.dart' as component_base;
import 'package:web_skin_dart/ui_core.dart';

/// A typedef for props that allow a custom rendering function to be provided to render some part of a component.
typedef ReactElement CustomRenderFunction<TProps extends UiProps, TState extends UiState, TComponent extends component_base.UiComponent> (TProps props, TState state, TComponent component);
