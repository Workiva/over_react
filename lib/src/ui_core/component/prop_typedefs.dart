library ui_core.prop_typedefs;

import 'package:react/react_client.dart';

/// A typedef for props that allow a custom rendering function to be provided to render some part of a component.
typedef ReactElement CustomRenderFunction<TProps extends Map, TState extends Map, TComponent> (TProps props, TState state, TComponent component);
