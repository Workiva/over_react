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
