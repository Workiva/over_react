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

class TargetLocator extends _WebDriverBase {
  TargetLocator._(driver) : super(driver, '');

  /// Change focus to another frame on the page.
  /// If [frame] is a:
  ///   [int]: select by its zero-based index
  ///   [String]: select frame by the name of the frame window or the id of the
  ///           frame or iframe tag.
  ///   [WebElement]: select the frame for a previously found frame or iframe
  ///               element.
  ///   not provided: selects the first frame on the page or the main document.
  ///
  ///   Throws [NoSuchFrameException] if the specified frame can't be found.
  Future frame([frame]) async {
    await _post('frame', {'id': frame});
  }

  /// Switch the focus of future commands for this driver to the window with the
  /// given name/handle.
  ///
  /// Throws [NoSuchWindowException] if the specified window can't be found.
  Future window(dynamic window) async {
    if (window is Window) {
      await _post('window', {'name': window.handle});
    } else if (window is String) {
      await _post('window', {'name': window});
    } else {
      throw 'Unsupported type: ${window.runtimeType}';
    }
  }

  /// Switches to the currently active modal dialog for this particular driver
  /// instance.
  ///
  /// Throws [NoSuchAlertException] if there is not currently an alert.
  Future<Alert> get alert async {
    var text = await _get('alert_text');
    return new Alert._(text, driver);
  }

  @override
  String toString() => '$driver.switchTo';

  @override
  int get hashCode => driver.hashCode;

  @override
  bool operator ==(other) => other is TargetLocator && other.driver == driver;
}
