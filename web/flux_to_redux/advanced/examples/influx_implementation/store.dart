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

import 'dart:math';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:w_flux/w_flux.dart' as flux;

class UpdateBackgroundColorAction {}

class UpdateBlockOneBackgroundColorAction {}

class UpdateBlockTwoBackgroundColorAction {}

class UpdateBlockThreeBackgroundColorAction {}

class RandomColorActions {
  final flux.Action<String> changeMainBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockOneBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockTwoBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockThreeBackgroundColor = flux.Action();
}

class TopLevelReduxState {
  String mainBackgroundColor;
  String blockOneBackgroundColor;

  TopLevelReduxState.defaultState()
      : this.mainBackgroundColor = 'gray',
        this.blockOneBackgroundColor = 'red';

  TopLevelReduxState.from(TopLevelReduxState oldState, {String? mainBackgroundColor, String? blockOneBackgroundColor})
      : this.mainBackgroundColor = mainBackgroundColor ?? oldState.mainBackgroundColor,
        this.blockOneBackgroundColor = blockOneBackgroundColor ?? oldState.blockOneBackgroundColor;
}

/// An Influx store
///
/// For a breakdown of specific changes, see the simple example
class RandomColorStore extends flux.Store with InfluxStoreMixin<TopLevelReduxState> {
  @override
  get reduxReducer => topLevelReduxReducer;

  RandomColorActions _actions;

  String get mainBackgroundColor => state.mainBackgroundColor;
  String get blockOneBackgroundColor => state.blockOneBackgroundColor;

  RandomColorStore(this._actions) {
    state = TopLevelReduxState.defaultState();
    triggerOnActionV2(_actions.changeMainBackgroundColor, (dynamic _) => this.influxReducer(UpdateBackgroundColorAction()));
    triggerOnActionV2(
        _actions.changeBlockOneBackgroundColor, (dynamic _) => this.influxReducer(UpdateBlockOneBackgroundColorAction()));
  }
}

class LowLevelReduxState {
  String backgroundColor;

  LowLevelReduxState.defaultState() : this.backgroundColor = 'Orange';

  LowLevelReduxState.from(LowLevelReduxState oldState, {String? backgroundColor})
      : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}

class LowLevelStore extends flux.Store with InfluxStoreMixin<LowLevelReduxState> {
  @override
  get reduxReducer => lowLevelReduxReducer;

  RandomColorActions _actions;

  /// Public data
  String get backgroundColor => state.backgroundColor;

  LowLevelStore(this._actions) {
    state = LowLevelReduxState.defaultState();
    triggerOnActionV2(
        _actions.changeBlockTwoBackgroundColor, (dynamic _) => this.influxReducer(UpdateBlockTwoBackgroundColorAction()));
  }
}

class AnotherReduxState {
  String backgroundColor;

  AnotherReduxState.defaultState() : this.backgroundColor = 'Blue';

  AnotherReduxState.from(AnotherReduxState oldState, {String? backgroundColor})
      : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}

class AnotherColorStore extends flux.Store with InfluxStoreMixin<AnotherReduxState> {
  @override
  get reduxReducer => anotherReduxReducer;

  RandomColorActions _actions;

  /// Public data
  String get backgroundColor => state.backgroundColor;

  AnotherColorStore(this._actions) {
    state = AnotherReduxState.defaultState();
    triggerOnActionV2(
        _actions.changeBlockThreeBackgroundColor, (dynamic _) => this.influxReducer(UpdateBlockThreeBackgroundColorAction()));
  }
}

TopLevelReduxState topLevelReduxReducer(TopLevelReduxState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    return TopLevelReduxState.from(oldState, mainBackgroundColor: color);
  } else if (action is UpdateBlockOneBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    return TopLevelReduxState.from(oldState, blockOneBackgroundColor: color);
  }

  return oldState;
}

LowLevelReduxState lowLevelReduxReducer(LowLevelReduxState oldState, dynamic action) {
  if (action is UpdateBlockTwoBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    return LowLevelReduxState.from(oldState, backgroundColor: color);
  }

  return oldState;
}

AnotherReduxState anotherReduxReducer(AnotherReduxState oldState, dynamic action) {
  if (action is UpdateBlockThreeBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
    return AnotherReduxState.from(oldState, backgroundColor: color);
  }

  return oldState;
}

RandomColorActions randomColorActions = RandomColorActions();
RandomColorStore randomColorStore = RandomColorStore(randomColorActions);
LowLevelStore lowLevelStore = LowLevelStore(randomColorActions);
AnotherColorStore anotherColorStore = AnotherColorStore(randomColorActions);

// Create a context instance for each new store instance
Context randomColorStoreContext = createContext();
Context lowLevelStoreContext = createContext();
Context anotherColorStoreContext = createContext();

// Create an adapter store for each new store instance
FluxToReduxAdapterStore randomColorStoreAdapter =
    randomColorStore.asReduxStore(randomColorActions);
FluxToReduxAdapterStore lowLevelStoreAdapter =
    lowLevelStore.asReduxStore(randomColorActions);
FluxToReduxAdapterStore anotherColorStoreAdapter =
    anotherColorStore.asReduxStore(randomColorActions);
