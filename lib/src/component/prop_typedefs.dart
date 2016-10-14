// Copyright 2016 Workiva Inc.
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

library over_react.prop_typedefs;

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:react/react_client.dart';

/// A typedef for props that allow a custom rendering function to be provided to render some part of a component.
typedef ReactElement CustomRenderFunction<TProps extends UiProps, TState extends UiState, TComponent extends component_base.UiComponent> (TProps props, TState state, TComponent component);
