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

import 'dart:collection';

import 'package:over_react/over_react.dart';

part 'abstract_transition_props.overReact.g.dart';

/// Props that mirror the implementation of [AbstractTransitionProps], made available as a mixin for components
/// that cannot extend directly from [AbstractTransitionComponent].
@PropsMixin()
abstract class $TransitionPropsMixin {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTransitionPropsMixin;

  static final TransitionPropsMapView defaultProps = new TransitionPropsMapView({})
    ..transitionCount = 1;

  Map get props;

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

class TransitionPropsMapView extends MapView with
// ignore: mixin_of_non_class,undefined_class
    $TransitionPropsMixin, TransitionPropsMixin {
  /// Create a new instance backed by the specified map.
  TransitionPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}
