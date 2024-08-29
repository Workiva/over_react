import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'ast_util.dart';

extension ReactTypes$DartType on DartType {
  bool get isComponentClass => typeOrBound.element?.isComponentClass ?? false;

  bool get isLegacyComponentClass => typeOrBound.element?.isLegacyComponentClass ?? false;

  bool get isReactElement => typeOrBound.element?.isReactElement ?? false;

  bool get isPropsClass => typeOrBound.element?.isPropsClass ?? false;

  bool get isStateHook => typeOrBound.element?.isStateHook ?? false;

  bool get isReducerHook => typeOrBound.element?.isReducerHook ?? false;

  bool get isTransitionHook => typeOrBound.element?.isTransitionHook ?? false;
}

extension ReactTypes$Element on Element {
  bool get isComponentClass => isOrIsSubtypeOfElementFromPackage('Component', 'react');

  bool get isLegacyComponentClass => isComponentClass && !isOrIsSubtypeOfElementFromPackage('Component2', 'react');

  bool get isReactElement => isOrIsSubtypeOfElementFromPackage('ReactElement', 'react');

  bool get isPropsClass => isOrIsSubtypeOfElementFromPackage('UiProps', 'over_react');

  bool get isStateHook => isOrIsSubtypeOfElementFromPackage('StateHook', 'react');

  bool get isReducerHook => isOrIsSubtypeOfElementFromPackage('ReducerHook', 'react');

  bool get isTransitionHook => false;

  // TODO uncomment one useTransition/TransitionHook is implemented
  // bool get isTransitionHook => isOrIsSubtypeOfElementFromPackage('TransitionHook', 'react');

  bool isOrIsSubtypeOfElementFromPackage(String typeName, String packageName) {
    final element = this;
    return element is InterfaceElement &&
        (element.isElementFromPackage(typeName, packageName) ||
            element.allSupertypes.any((type) => type.element.isElementFromPackage(typeName, packageName)));
  }
}

// Adapted from https://github.com/dart-lang/sdk/blob/279024d823707f1f4d5edc05c374ca813edbd73e/pkg/analysis_server/lib/src/utilities/flutter.dart#L560
//
// Copyright 2014, the Dart project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
extension ElementPackageUtils on Element {
  bool isElementFromPackage(String typeName, String packageName) =>
      name == typeName && isDeclaredInPackage(packageName);

  bool isDeclaredInPackage(String packageName) {
    final uri = source?.uri;
    return uri != null && isUriWithinPackage(uri, packageName);
  }
}

bool isUriWithinPackage(Uri uri, String packageName) =>
    uri.isScheme('package') && uri.pathSegments.isNotEmpty && uri.pathSegments[0] == packageName;
