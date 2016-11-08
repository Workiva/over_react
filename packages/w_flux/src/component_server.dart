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

library w_flux.src.component_server;

import 'package:w_flux/src/component_common.dart';
import 'package:w_flux/src/store.dart';

/// FluxComponents are responsible for rendering application views and turning
/// user interactions and events into [Action]s. FluxComponents can use data
/// from one or many [Store] instances to define the resulting component.
///
/// This FluxComponent, intended for use on the server, does not depend on
/// dart:html.
abstract class FluxComponent<ActionsT, StoresT>
    extends FluxComponentCommon<ActionsT, StoresT> {}
