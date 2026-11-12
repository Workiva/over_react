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

library over_react.component_base;

import 'src/component_declaration/component_base.dart' as cb;

export 'src/component_declaration/component_base.dart' hide PropsMapViewMixin, StateMapViewMixin, MapViewMixin;

// Typedefs instead of deprecating the export to work around message not showing: https://github.com/dart-lang/sdk/issues/52163

@Deprecated('Not for public use. Will be removed in a future major release.')
typedef PropsMapViewMixin = cb.PropsMapViewMixin;

@Deprecated('Not for public use. Will be removed in a future major release.')
typedef StateMapViewMixin = cb.StateMapViewMixin;

@Deprecated('Not for public use. Will be removed in a future major release.')
typedef MapViewMixin = cb.MapViewMixin;
