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

// ignore_for_file: prefer_generic_function_type_aliases
library over_react.prop_typedefs;

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:react/react_client.dart';

/// A custom rendering prop typedef that allows a custom rendering function to be provided
/// with the current [props] and [state] of the [component].
typedef ReactElement? CustomRenderFunction<T extends UiProps,
                                          S extends UiState,
                                          // ignore: deprecated_member_use_from_same_package
                                          C extends component_base.UiComponent> (T props, S state, C component);
