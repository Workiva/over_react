// Copyright 2016 Workiva Inc.
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

// ignore_for_file: deprecated_member_use_from_same_package
library over_react.map_util;

import 'dart:collection';

import 'package:over_react/src/component/dom_components.dart';
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/component/prop_mixins.dart';
import 'package:react/react_client/js_backed_map.dart';

import '../component_declaration/builder_helpers.dart';

/// Returns a copy of the specified [props] map, omitting reserved React props by default,
/// in addition to any specified [keysToOmit] or [keySetsToOmit].
///
/// If [onlyCopyDomProps] is `true`, only the keys found within [DomPropsMixin] and [SvgPropsMixin] will be forwarded.
///
/// Useful for prop forwarding.
Map getPropsToForward(Map props, {
    bool omitReactProps = true,
    bool onlyCopyDomProps = false,
    Iterable keysToOmit,
    Iterable<Iterable> keySetsToOmit
}) {
  Map propsToForward = JsBackedMap.from(props);

  if (omitReactProps) {
    propsToForward
      ..remove('key')
      ..remove('ref')
      ..remove('children');
  }

  if (keysToOmit != null) {
    keysToOmit.forEach((key) {
      propsToForward.remove(key);
    });
  }

  if (keySetsToOmit != null) {
    keySetsToOmit.forEach((keySet) {
      keySet.forEach((key) {
        propsToForward.remove(key);
      });
    });
  }

  if (onlyCopyDomProps) {
    List<String>.from(propsToForward.keys).forEach((key) {
      if (key.startsWith('aria-')) return;
      if (key.startsWith('data-')) return;
      if (_validDomProps.contains(key)) return;

      propsToForward.remove(key);
    });
  }

  return propsToForward;
}

/// Adds unconsumed props to a passed in [Map] reference ([propsToUpdate]).
///
/// Based upon configuration, the function will overlook [props] that are not
/// meant to be passed on, such as non-DOM props or specified values.
///
/// DEPRECATED: Use [forwardUnconsumedPropsV2] instead.
@Deprecated('This implementation does not filter DOM props correctly. Use forwardUnconsumedPropsV2 instead.')
void forwardUnconsumedProps(Map props, {
  bool omitReactProps = true,
  bool onlyCopyDomProps = false,
  Iterable keysToOmit,
  Iterable<Iterable> keySetsToOmit,
  Map propsToUpdate,
}) {
  if (onlyCopyDomProps) {
    for (final key in props.keys) {
      if ((key is String && (key.startsWith('aria-') ||
          key.startsWith('data-'))) ||
          _validDomProps.contains(key)) {
        propsToUpdate[key] = props[key];
      }
    }
    return;
  }

  for (final key in props.keys) {
    if (keysToOmit != null && keysToOmit.contains(key)) continue;

    if (keySetsToOmit != null && keySetsToOmit.isNotEmpty) {
      /// If the passed in value of [keySetsToOmit] comes from
      /// [addUnconsumedProps], there should only be a single index.
      /// Consequently, this case exists to give the opportunity for the loop
      /// to continue without initiating another loop (which is less
      /// performant than `.first.contains()`).
      /// TODO: further optimize this by identifying the best looping / data structure
      if (keySetsToOmit.first.contains(key)) continue;

      if (keySetsToOmit.length > 1) {
        bool shouldContinue = false;
        for (final keySet in keySetsToOmit) {
          if (keySet.contains(key)) {
            shouldContinue = true;
            break;
          }
        }

        if (shouldContinue) continue;
      }
    }

    if (omitReactProps && const ['key', 'ref', 'children'].contains(key)) continue;

    propsToUpdate[key] = props[key];
  }
}

/// Adds unconsumed props to a passed in [Map] reference ([propsToUpdate]).
///
/// Based upon configuration, the function will overlook [props] that are not
/// meant to be passed on, such as non-DOM props or specified values.
///
/// Identical to [forwardUnconsumedProps], with the exception of properly filtering
/// DOM props.
void forwardUnconsumedPropsV2(Map props, {
  bool omitReactProps = true,
  bool onlyCopyDomProps = false,
  Iterable keysToOmit,
  Iterable<Iterable> keySetsToOmit,
  Map propsToUpdate,
}) {
    for (final key in props.keys) {
      if (keysToOmit != null && keysToOmit.contains(key)) continue;

      if (keySetsToOmit != null && keySetsToOmit.isNotEmpty) {
        // If the passed in value of [keySetsToOmit] comes from
        // [addUnconsumedProps], there should only be a single index.
        // Consequently, this case exists to give the opportunity for the loop
        // to continue without initiating another loop (which is less
        // performant than `.first.contains()`).
        // TODO: further optimize this by identifying the best looping / data structure
        if (keySetsToOmit != null && keySetsToOmit.first.contains(key)) continue;

        if (keySetsToOmit.length > 1) {
          bool shouldContinue = false;
          for (final keySet in keySetsToOmit) {
            if (keySet.contains(key)) {
              shouldContinue = true;
              break;
            }
          }

          if (shouldContinue) continue;
        }
      }

      if (onlyCopyDomProps && !((key is String && (key.startsWith('aria-') ||
          key.startsWith('data-'))) ||
          _validDomProps.contains(key))) {
        continue;
      }

    if (omitReactProps && const ['key', 'ref', 'children'].contains(key)) continue;

    propsToUpdate[key] = props[key];
  }
}

/// Returns a copy of the [DomPropsMixin.style] map found in [props].
///
/// Returns an empty map if [props] or its style map are `null`.
Map<String, dynamic> newStyleFromProps(Map props) {
  if (props == null) return <String, dynamic>{};

  var existingStyle = domProps(props).style;
  return existingStyle == null ? <String, dynamic>{} : Map.from(existingStyle);
}

/// Returns the underlying map object of either [UiProps] or [UiState].
///
/// Used to take a typed factory object and get the underlying backing map.
Map getBackingMap(Map map) {
  if (map is JsBackedMap) return map;
  if (map is component_base.UiProps) return getBackingMap(map.props);
  if (map is component_base.UiState) return getBackingMap(map.state);
  return map;
}

HashSet _validDomProps = HashSet()
  ..addAll(DomPropsMixin.meta.keys)
  ..addAll(SvgPropsMixin.meta.keys);
