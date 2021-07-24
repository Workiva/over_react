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

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart';

part 'custom_error_boundary.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<CustomErrorBoundaryProps> CustomErrorBoundary = _$CustomErrorBoundary;

@Props()
class _$CustomErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}

class CustomErrorBoundaryProps extends _$CustomErrorBoundaryProps
// ignore: mixin_of_non_class, undefined_class
    with _$CustomErrorBoundaryPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForCustomErrorBoundaryProps;
}

@State()
class _$CustomErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}

class CustomErrorBoundaryState extends _$CustomErrorBoundaryState
// ignore: mixin_of_non_class, undefined_class
    with _$CustomErrorBoundaryStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value, invalid_assignment
  static const StateMeta meta = _$metaForCustomErrorBoundaryState;
}

@Component2(isErrorBoundary: true)
class CustomErrorBoundaryComponent extends UiStatefulComponent2<CustomErrorBoundaryProps, CustomErrorBoundaryState>
    with ErrorBoundaryMixin<CustomErrorBoundaryProps, CustomErrorBoundaryState> {
  @override
   get defaultProps => (newProps()
    ..addAll(super.defaultProps)
    ..fallbackUIRenderer = _renderFallbackUI
  );

  ReactElement _renderFallbackUI(_, __) {
    return Dom.div()(
      Dom.h3()('Error!'),
    );
  }
}
