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

class WebElement extends _WebDriverBase implements SearchContext {
  final String id;

  /// The context from which this element was found.
  final SearchContext context;

  /// How the element was located from the context.
  final dynamic /* String | Finder */ locator;

  /// The index of this element in the set of element founds. If the method
  /// used to find this element always returns one element, then this is null.
  final int index;

  WebElement._(driver, id, [this.context, this.locator, this.index])
      : this.id = id,
        super(driver, 'element/$id');

  /// Click on this element.
  Future click() async {
    await _post('click');
  }

  /// Submit this element if it is part of a form.
  Future submit() async {
    await _post('submit');
  }

  /// Send [keysToSend] to this element.
  Future sendKeys(String keysToSend) async {
    await _post('value', {
      'value': [keysToSend]
    });
  }

  /// Clear the content of a text element.
  Future clear() async {
    await _post('clear');
  }

  /// Is this radio button/checkbox selected?
  Future<bool> get selected => _get('selected') as Future<bool>;

  /// Is this form element enabled?
  Future<bool> get enabled => _get('enabled') as Future<bool>;

  /// Is this element visible in the page?
  Future<bool> get displayed => _get('displayed') as Future<bool>;

  /// The location within the document of this element.
  Future<Point> get location async {
    var point = await _get('location');
    return new Point<int>(point['x'].toInt(), point['y'].toInt());
  }

  /// The size of this element.
  Future<Rectangle<int>> get size async {
    var size = await _get('size');
    return new Rectangle<int>(
        0, 0, size['width'].toInt(), size['height'].toInt());
  }

  /// The tag name for this element.
  Future<String> get name => _get('name') as Future<String>;

  ///  Visible text within this element.
  Future<String> get text => _get('text') as Future<String>;

  ///Find an element nested within this element.
  ///
  /// Throws [NoSuchElementException] if matching element is not found.
  Future<WebElement> findElement(By by) async {
    var element = await _post('element', by);
    return new WebElement._(driver, element[_element], this, by);
  }

  /// Find multiple elements nested within this element.
  Stream<WebElement> findElements(By by) async* {
    var elements = await _post('elements', by);
    int i = 0;
    for (var element in elements) {
      yield new WebElement._(driver, element[_element], this, by, i);
      i++;
    }
  }

  /// Access to the HTML attributes of this tag.
  ///
  /// TODO(DrMarcII): consider special handling of boolean attributes.
  Attributes get attributes => new Attributes._(driver, '$_prefix/attribute');

  /// Access to the cssProperties of this element.
  ///
  /// TODO(DrMarcII): consider special handling of color and possibly other
  /// properties.
  Attributes get cssProperties => new Attributes._(driver, '$_prefix/css');

  /// Does this element represent the same element as another element?
  /// Not the same as ==
  Future<bool> equals(WebElement other) =>
      _get('equals/${other.id}') as Future<bool>;

  Map<String, String> toJson() => {_element: id};

  @override
  int get hashCode => driver.hashCode * 3 + id.hashCode;

  @override
  bool operator ==(other) =>
      other is WebElement && other.driver == this.driver && other.id == this.id;

  @override
  String toString() {
    var out = new StringBuffer()..write(context);
    if (locator is By) {
      if (index == null) {
        out..write('.findElement(');
      } else {
        out..write('.findElements(');
      }
      out..write(locator)..write(')');
    } else {
      out..write('.')..write(locator);
    }
    if (index != null) {
      out..write('[')..write(index)..write(']');
    }
    return out.toString();
  }
}
