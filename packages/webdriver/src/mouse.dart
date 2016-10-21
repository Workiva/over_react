// Copyright 2015 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of webdriver.core;

class MouseButton {
  /// The primary button is usually the left button or the only button on
  /// single-button devices, used to activate a user interface control or select
  /// text.
  static const MouseButton primary = const MouseButton._(0);

  /// The auxiliary button is usually the middle button, often combined with a
  /// mouse wheel.
  static const MouseButton auxiliary = const MouseButton._(1);

  /// The secondary button is usually the right button, often used to display a
  /// context menu.
  static const MouseButton secondary = const MouseButton._(2);

  final int value;

  /// [value] for a mouse button is defined in
  /// https://w3c.github.io/uievents/#widl-MouseEvent-button
  const MouseButton._(this.value);
}

class Mouse extends _WebDriverBase {
  Mouse._(driver) : super(driver, '');

  /// Click any mouse button (at the coordinates set by the last moveTo).
  Future click([MouseButton button]) async {
    var json = {};
    if (button is MouseButton) {
      json['button'] = button.value;
    }
    await _post('click', json);
  }

  /// Click and hold any mouse button (at the coordinates set by the last
  /// moveTo command).
  Future down([MouseButton button]) async {
    var json = {};
    if (button is MouseButton) {
      json['button'] = button.value;
    }
    await _post('buttondown', json);
  }

  /// Releases the mouse button previously held (where the mouse is currently at).
  Future up([MouseButton button]) async {
    var json = {};
    if (button is MouseButton) {
      json['button'] = button.value;
    }
    await _post('buttonup', json);
  }

  /// Double-clicks at the current mouse coordinates (set by moveTo).
  Future doubleClick() async {
    await _post('doubleclick');
  }

  /// Move the mouse.
  ///
  /// If [element] is specified and [xOffset] and [yOffset] are not, will move
  /// the mouse to the center of the [element].
  ///
  /// If [xOffset] and [yOffset] are specified, will move the mouse that distance
  /// from its current location.
  ///
  /// If all three are specified, will move the mouse to the offset relative to
  /// the top-left corner of the [element].
  /// All other combinations of parameters are illegal.
  Future moveTo({WebElement element, int xOffset, int yOffset}) async {
    var json = {};
    if (element is WebElement) {
      json['element'] = element.id;
    }
    if (xOffset is num && yOffset is num) {
      json['xoffset'] = xOffset.floor();
      json['yoffset'] = yOffset.floor();
    }
    await _post('moveto', json);
  }

  @override
  String toString() => '$driver.mouse';

  @override
  int get hashCode => driver.hashCode;

  @override
  bool operator ==(other) => other is Mouse && other.driver == driver;
}
