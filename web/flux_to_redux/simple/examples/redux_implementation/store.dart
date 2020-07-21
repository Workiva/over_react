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

import 'package:redux/redux.dart' as redux;

class UpdateBackgroundColorAction {}

class RandomColorState {
  String backgroundColor;

  RandomColorState.defaultState() : this.backgroundColor = 'gray';

  RandomColorState.update(RandomColorState oldState, {backgroundColor})
      : this.backgroundColor = backgroundColor ?? oldState.backgroundColor;
}

RandomColorState reducer(RandomColorState oldState, dynamic action) {
  if (action is UpdateBackgroundColorAction) {
    var color = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);

    return RandomColorState.update(oldState, backgroundColor: color);
  }

  return oldState;
}

redux.Store randomColorStore = redux.Store<RandomColorState>(reducer, initialState: RandomColorState.defaultState());
