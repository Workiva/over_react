import 'dart:math';

import 'package:w_flux/w_flux.dart' as flux;

class RandomColorActions {
  final flux.Action<String> changeMainBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockOneBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockTwoBackgroundColor = flux.Action();

  final flux.Action<String> changeBlockThreeBackgroundColor = flux.Action();
}

class RandomColorStore extends flux.Store {
  RandomColorActions _actions;
  MidLevelStore midLevelStore = MidLevelStore(randomColorActions);

  /// Public data
  String _backgroundColor = 'gray';
  String get backgroundColor => _backgroundColor;

  RandomColorStore(this._actions) {
    triggerOnActionV2(_actions.changeMainBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class MidLevelStore extends flux.Store {
  RandomColorActions _actions;

  LowLevelStore lowLevelStore = LowLevelStore(randomColorActions);

  /// Public data
  String _backgroundColor = 'Red';
  String get backgroundColor => _backgroundColor;

  MidLevelStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockOneBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class LowLevelStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String _backgroundColor = 'Orange';
  String get backgroundColor => _backgroundColor;

  LowLevelStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockTwoBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

class AnotherColorStore extends flux.Store {
  RandomColorActions _actions;

  /// Public data
  String _backgroundColor = 'Blue';
  String get backgroundColor => _backgroundColor;

  AnotherColorStore(this._actions) {
    triggerOnActionV2(_actions.changeBlockThreeBackgroundColor, _changeBackgroundColor);
  }

  _changeBackgroundColor(String _) {
    _backgroundColor = '#' + (Random().nextDouble() * 16777215).floor().toRadixString(16);
  }
}

RandomColorActions randomColorActions = RandomColorActions();
RandomColorStore bigStore = RandomColorStore(randomColorActions);
AnotherColorStore littleStore = AnotherColorStore(randomColorActions);
