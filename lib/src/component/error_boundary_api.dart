// Copyright 2020 Workiva Inc.
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

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as v2;

@visibleForTesting
const String defaultErrorBoundaryLoggerName = 'over_react.ErrorBoundary';

/// An API mixin used for shared APIs in ErrorBoundary Components.
mixin ErrorBoundaryApi<T extends v2.ErrorBoundaryProps, S extends v2.ErrorBoundaryState> on UiStatefulComponent2<T, S> {
  /// Resets the [v2.ErrorBoundary] to a non-error state.
  ///
  /// This can be called manually on the component instance using a `ref` -
  /// or by passing in a new child instance after a child has thrown an error.
  void reset() {
    setState(initialState);
  }
}
