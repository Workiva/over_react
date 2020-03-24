// Copyright 2017 Workiva Inc.
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

library over_react.abstract_transition_props;

import 'package:over_react/over_react.dart' hide AbstractTransitionComponent, AbstractTransitionProps;
import 'package:over_react/components.dart' show AbstractTransitionComponent, AbstractTransitionProps;

part 'abstract_transition_props.over_react.g.dart';


/// Props that mirror the implementation of [AbstractTransitionProps], made available as a mixin for components
/// that cannot extend directly from [AbstractTransitionComponent].
mixin TransitionPropsMixin on UiProps {
  static final TransitionPropsMixin defaultProps = TransitionPropsMapView({})
    ..transitionCount = 1;

  /// The number of `transitionend` event that occur when the transition node is shown/hidden.
  ///
  /// Serves as the default for [transitionInCount]/[transitionOutCount] when they are not specified.
  ///
  /// Default: `1`
  int transitionCount;

  /// The number of `transitionend` event that occur when the transition node is shown.
  ///
  /// Default: [transitionCount]
  int transitionInCount;

  /// The number of `transitionend` event that occur when the transition node is hidden.
  ///
  /// Default: [transitionCount]
  int transitionOutCount;

  /// Optional callback that fires before the [AbstractTransitionComponent] is hidden.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will remain visible.
  Callback onWillHide;

  /// Optional callback that fires after the [AbstractTransitionComponent] is hidden.
  Callback onDidHide;

  /// Optional callback that fires before the [AbstractTransitionComponent] appears.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will not appear.
  Callback onWillShow;

  /// Optional callback that fires after the [AbstractTransitionComponent] appears.
  Callback onDidShow;
}

UiFactory<TransitionPropsMixin> TransitionPropsMapView = _$TransitionPropsMapView;
