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

const String _element = 'ELEMENT';

/// Simple class to provide access to indexed properties such as WebElement
/// attributes or css styles.
class Attributes extends _WebDriverBase {
  Attributes._(driver, command) : super(driver, command);

  Future<String> operator [](String name) => _get(name) as Future<String>;
}

abstract class SearchContext {
  WebDriver get driver;

  /// Searches for multiple elements within the context.
  Stream<WebElement> findElements(By by);

  /// Searches for an element within the context.
  ///
  /// Throws [NoSuchElementException] if no matching element is found.
  Future<WebElement> findElement(By by);
}

abstract class _WebDriverBase {
  final String _prefix;
  final WebDriver driver;

  _WebDriverBase(this.driver, this._prefix);

  Future _post(String command, [param]) =>
      driver.postRequest(_resolve(command), param);

  Future _get(String command) => driver.getRequest(_resolve(command));

  Future _delete(String command) => driver.deleteRequest(_resolve(command));

  String _resolve(command) {
    if (_prefix == null || _prefix.isEmpty) {
      return command;
    }
    if (command == null || command.isEmpty) {
      return _prefix;
    }
    return '$_prefix/$command';
  }
}

class By {
  final String _using;
  final String _value;

  const By._(this._using, this._value);

  /// Returns an element whose ID attribute matches the search value.
  const By.id(String id) : this._('id', id);

  /// Returns an element matching an XPath expression.
  const By.xpath(String xpath) : this._('xpath', xpath);

  /// Returns an anchor element whose visible text matches the search value.
  const By.linkText(String linkText) : this._('link text', linkText);

  /// Returns an anchor element whose visible text partially matches the search
  /// value.
  const By.partialLinkText(String partialLinkText)
      : this._('partial link text', partialLinkText);

  /// Returns an element whose NAME attribute matches the search value.
  const By.name(String name) : this._('name', name);

  /// Returns an element whose tag name matches the search value.
  const By.tagName(String tagName) : this._('tag name', tagName);

  /**
   * Returns an element whose class name contains the search value; compound
   * class names are not permitted
   */
  const By.className(String className) : this._('class name', className);

  /// Returns an element matching a CSS selector.
  const By.cssSelector(String cssSelector)
      : this._('css selector', cssSelector);

  Map<String, String> toJson() => {'using': _using, 'value': _value};

  @override
  String toString() {
    var constructor;
    switch (_using) {
      case 'link text':
        constructor = 'linkText';
        break;
      case 'partial link text':
        constructor = 'partialLinkText';
        break;
      case 'tag name':
        constructor = 'tagName';
        break;
      case 'class name':
        constructor = 'className';
        break;
      case 'css selector':
        constructor = 'cssSelector';
        break;
      default:
        constructor = _using;
    }
    return 'By.$constructor($_value)';
  }

  @override
  int get hashCode => _using.hashCode * 3 + _value.hashCode;

  @override
  bool operator ==(other) =>
      other is By && other._using == this._using && other._value == this._value;
}
