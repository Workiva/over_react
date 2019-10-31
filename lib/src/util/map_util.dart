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

library over_react.map_util;

import 'dart:collection';

import 'package:over_react/src/component/dom_components.dart';
import 'package:over_react/src/component/prop_mixins.dart';

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
  Map propsToForward = Map.from(props);

  if (omitReactProps) {
    propsToForward..remove('key')..remove('ref')..remove('children');
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

/// Returns a copy of the [DomPropsMixin.style] map found in [props].
///
/// Returns an empty map if [props] or its style map are `null`.
Map<String, dynamic> newStyleFromProps(Map props) {
  if (props == null) return <String, dynamic>{};

  var existingStyle = domProps(props).style;
  return existingStyle == null ? <String, dynamic>{} : Map.from(existingStyle);
}

SplayTreeSet _validDomProps = SplayTreeSet()
  ..addAll(DomPropsMixin.meta.keys)
  ..addAll(SvgPropsMixin.meta.keys);
