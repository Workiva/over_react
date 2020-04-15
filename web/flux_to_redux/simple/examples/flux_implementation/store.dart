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

import 'package:w_flux/w_flux.dart' as flux;

class RandomColorStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String _backgroundColor = 'gray';
  String get backgroundColor => _backgroundColor;

  RandomColorStore(this._actions) {
    triggerOnActionV2(_actions.changeBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class RandomColorActions {
  final flux.Action<String> changeBackgroundColor = flux.Action();
}

RandomColorActions randomColorActions = RandomColorActions();
RandomColorStore randomColorStore = RandomColorStore(randomColorActions);
