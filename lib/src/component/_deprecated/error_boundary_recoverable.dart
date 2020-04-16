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

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/_deprecated/error_boundary_mixins.dart';

part 'error_boundary_recoverable.over_react.g.dart';

/// A higher-order component that will catch "recoverable" ReactJS errors, errors outside of the render/mount cycle,
/// anywhere within the child component tree and display a fallback UI instead of the component tree that crashed.
///
/// __NOTE:__
///   1. This component is not / should never be publicly exported.
///   2. This component should never be used, except as a child of the outer (public) `ErrorBoundary` component.
@Deprecated('For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
@Factory()
UiFactory<RecoverableErrorBoundaryProps> RecoverableErrorBoundary = _$RecoverableErrorBoundary;

@Deprecated('For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
@Props()
class _$RecoverableErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}

@Deprecated('For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
@State()
class _$RecoverableErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}

@Deprecated('For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
@Component2(isWrapper: true, isErrorBoundary: true)
class RecoverableErrorBoundaryComponent<T extends RecoverableErrorBoundaryProps, S extends RecoverableErrorBoundaryState>
    extends UiStatefulComponent2<T, S> with ErrorBoundaryMixin<T, S>, LegacyErrorBoundaryApi<T, S> {}
