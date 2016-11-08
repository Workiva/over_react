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

class Window extends _WebDriverBase {
  final String handle;

  Window._(driver, handle)
      : this.handle = handle,
        super(driver, 'window/$handle');

  /// The size of this window.
  Future<Rectangle<int>> get size async {
    var size = await _get('size');
    return new Rectangle<int>(
        0, 0, size['width'].toInt(), size['height'].toInt());
  }

  /// The location of this window.
  Future<Point<int>> get location async {
    var point = await _get('position');
    return new Point<int>(point['x'].toInt(), point['y'].toInt());
  }

  /// Maximize this window.
  Future maximize() async {
    await _post('maximize');
  }

  /// Set this window size.
  Future setSize(Rectangle<int> size) async {
    await _post(
        'size', {'width': size.width.toInt(), 'height': size.height.toInt()});
  }

  /// Set this window location.
  Future setLocation(Point<int> point) async {
    await _post('position', {'x': point.x.toInt(), 'y': point.y.toInt()});
  }

  @override
  int get hashCode => handle.hashCode * 3 + driver.hashCode;

  @override
  bool operator ==(other) =>
      other is Window &&
      other.driver == this.driver &&
      other.handle == this.handle;

  @override
  String toString() => '$driver.windows[$handle]';
}
