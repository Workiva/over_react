// Copyright (c) 2013-2016, the Clean project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library react_server;

import 'dart:math';
import 'dart:typed_data';

import 'package:react/react.dart';
import 'package:react/react_dom_server.dart';
import 'package:quiver/iterables.dart';

// ReactJS constants needed to create correct checksum
String _SEPARATOR = '.';
String _ID_ATTR_NAME = 'data-reactid';
String _CHECKSUM_ATTR_NAME = 'data-react-checksum';
num    _GLOBAL_MOUNT_POINT_MAX = 9999999;
num    _MOD = 65521;



typedef String OwnerFactory([String ownerId, num position, String key]);
typedef OwnerFactory ReactComponentFactory(Map props, [dynamic children]);
typedef Component ComponentFactory();

/// Creates a method that creates a new [Component], runs lifecycle methods and returns the result of the
/// [componentFactory] instance `render` method.
ReactComponentFactory _registerComponent(ComponentFactory componentFactory, [Iterable<String> skipMethods = const []]) {
  /// Cached default props.
  final Map defaultProps = componentFactory().getDefaultProps();

  return (Map props, [dynamic children]) {
    Component component = componentFactory();

    // Get default props, add children to props and apply props from arguments
    var extendedProps = new Map.from(defaultProps)
      ..addAll(props)
      ..['children'] = children;
    component.initComponentInternal(extendedProps, () {});

    // Get initial state
    component.initStateInternal();
    component.componentWillMount();

    // If componentWillMount called setState or replaceState, then transfer this state to actual state.
    component.transferComponentState();

    // Return result of component.render()
    return ([String ownerId, num position, String key]) {
      return component.render()(ownerId, position, key);
    };
  };
}

/// Create DOM component factory
ReactComponentFactory _reactDom(String name) {
  return (Map args, [children]) {
    // Pack component string creation into function to easily pass owner id, position and key
    // (from its custom component owner)
    return ([String ownerId, num position, String key]) {
      if (_selfClosingElementTags.contains(name) && (children != null && children.length > 0)) {
        throw new Exception('$name element does not accept children.');
      }

      // Count react id
      // If args contains key, then replace argument key by that key.
      if (args.containsKey('key')) {
        key = args['key'].toString();
      }

      // If ownerId is not set, then this is a rootNode - create rootId for it.
      String thisId;
      if (ownerId == null) {
        thisId = _createRootId();
      } else {
        // If ownerId is set, append adequate string to parent id based on position and key.
        thisId = ownerId + (key != null ? '.\$$key' : (position != null ? '.${position.toInt().toRadixString(36)}' : '.0'));
      }

      // Create StringBuffer to build result, append open tag to it
      StringBuffer result = new StringBuffer('<$name');

      // Add attributes to it and prepare args to be the same as in ReactJS
      args.forEach((key,value) {
        String toWrite = _parseDomArgument(key, value);
        if (toWrite != null) result.write(toWrite);
      });

      // Add id after attributes
      result.write(' $_ID_ATTR_NAME="$thisId"');

      // Close the opening tag
      result.write('>');

      // If it's not a self-closing tag, add children
      if (!_selfClosingElementTags.contains(name)) {
        if (children is Iterable) {
          enumerate(children.where((child) => child != null)).forEach((value) {
            num i = value.index;
            var component = value.value;
            if (component is String) {
              result.write(span({}, component)(thisId, i));
            } else {
              result.write(component(thisId, i));
            }
          });
        } else if (children != null) {
          if (children is String) {
            result.write(_escapeTextForBrowser(children));
          } else if (children is Function) {
            result.write(children(thisId, 0));
          } else {
            result.write(children);
          }
        }

        // Add a closing tag after the children
        result.write('</$name>');
      }

      // Return result as a string
      return result.toString();
    };
  };
}

/// Convert DOM arguments (delete event handlers and [key])
String _parseDomArgument(String key, dynamic value) {
  if(value == null) return '';
  // Synthetic events must not pass to string and key too
  if(_syntheticEvents.contains(key)) return null;
  if(key == 'key') return null;
  if(key == 'ref') return null;

  // Change "className" to class
  if (key == 'className') {
    key = 'class';
  }

  // Change "htmlFor" to "for"
  if (key == 'htmlFor') {
    key = 'for';
  }

  if (key == 'style' && value is Map) {
    Map style = value;
    value = style.keys.map((key) => '$key:${style[key]};').join('');
  }

  if(key == 'value' && value is List) {
    value = value[0];
    if (value is! String) value = value.toString();
  }

  value = _escapeTextForBrowser(value);
  return ' ${key.toLowerCase()}="$value"';
}

var _ESCAPE_LOOKUP = {
  '&': '&amp;',
  '>': '&gt;',
  '<': '&lt;',
  '"': '&quot;',
  '\'': '&#x27;',
  '/': '&#x2f;'
};

var _ESCAPE_REGEX = new RegExp('[&><\\\'/]');

String _escaper(Match match) {
  return _ESCAPE_LOOKUP[match.group(0)];
}

/// Escapes [text] to prevent scripting attacks.
String _escapeTextForBrowser(text) {
  return ('' + text).replaceAllMapped(_ESCAPE_REGEX, _escaper);
}

/// Set of all in client converted synthetic events
Set _syntheticEvents = new Set.from([
  'onCopy', 'onCut', 'onPaste', 'onKeyDown', 'onKeyPress', 'onKeyUp', 'onFocus', 'onBlur', 'onChange', 'onInput',
  'onSubmit', 'onClick', 'onDoubleClick', 'onDrag', 'onDragEnd', 'onDragEnter', 'onDragExit', 'onDragLeave',
  'onDragOver', 'onDragStart', 'onDrop', 'onMouseDown', 'onMouseEnter', 'onMouseLeave', 'onMouseMove', 'onMouseOut',
  'onMouseOver', 'onMouseUp', 'onTouchCancel', 'onTouchEnd', 'onTouchMove', 'onTouchStart', 'onScroll', 'onWheel',
]);

/// Set of HTML [Element] names that can contain children
Set _elementTags = new Set.from([
  'a', 'abbr', 'address', 'article', 'aside', 'audio', 'b', 'bdi', 'bdo', 'big', 'blockquote', 'body', 'button',
  'canvas', 'caption', 'cite', 'code', 'colgroup', 'data', 'datalist', 'dd', 'del', 'details', 'dfn', 'dialog', 'div',
  'dl', 'dt', 'em', 'fieldset', 'figcaption', 'figure', 'footer', 'form', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head',
  'header', 'html', 'i', 'iframe', 'ins', 'kbd', 'label', 'legend', 'li', 'main', 'map', 'mark', 'menu', 'menuitem',
  'meter', 'nav', 'noscript', 'object', 'ol', 'optgroup', 'option', 'output', 'p', 'picture', 'pre', 'progress', 'q',
  'rp', 'rt', 'ruby', 's', 'samp', 'script', 'section', 'select', 'small', 'span', 'strong', 'style', 'sub', 'summary',
  'sup', 'table', 'tbody', 'td', 'textarea', 'tfoot', 'th', 'thead', 'time', 'title', 'tr', 'u', 'ul', 'variable',
  'video', 'defs', 'g', 'linearGradient', 'mask', 'pattern', 'radialGradient', 'svg', 'text', 'tspan',
]);

/// Set of HTML [Element] names that are "self-closing"
Set _selfClosingElementTags = new Set.from([
  'area', 'base', 'br', 'col', 'hr', 'img', 'input', 'link', 'meta', 'param', 'command', 'embed', 'keygen', 'source',
  'track', 'wbr', 'circle', 'ellipse', 'line', 'path', 'polygon', 'polyline', 'rect', 'stop',
]);


String _renderComponentToString(OwnerFactory component) {
  return _addChecksumToMarkup(component());
}

String _renderToStaticMarkup(OwnerFactory component) {
  return _removeReactIdFromMarkup(component());
}

/// Creates random id based on id creation in react.js
String _createRootId() {
  var rng = new Random();
  return '${_SEPARATOR}r[${rng.nextInt(_GLOBAL_MOUNT_POINT_MAX).toRadixString(36)}]';
}

/// Count checksum and add it to markup as last attribute of root element
String _addChecksumToMarkup(String markup) {
  var checksum = _adler32(markup);
  return markup.replaceFirst(
      '>',
      ' $_CHECKSUM_ATTR_NAME="$checksum">'
  );
}

String _removeReactIdFromMarkup(String markup) {
  var matcher = new RegExp(' $_ID_ATTR_NAME=".+?"');
  return markup.replaceAll(matcher, '');
}

/// Checksum algorithm copied from react.js
///
/// Must be the same to enable react.js to recognize it.
///
/// JS uses 4-byte signed integers for binary operations while dart adjusts it, so Int32x4 is used for it
_adler32(String data) {
  int a = 1;
  int b = 0;
  for (var i = 0; i < data.length; i++) {
    a = (a + data.codeUnitAt(i)) % _MOD;
    b = (b + a) % _MOD;
  }
  var A = new Int32x4(a, 0, 0, 0);
  var B = new Int32x4(b << 16, 0, 0, 0);
  return (A | B).x;
}

void setServerConfiguration() {
  setReactConfiguration(_reactDom, _registerComponent);
  setReactDOMServerConfiguration(_renderComponentToString, _renderToStaticMarkup);
}
