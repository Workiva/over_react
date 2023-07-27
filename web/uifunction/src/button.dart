// Copyright 2020 Workiva Inc.
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

import 'dart:js_util';

import 'package:over_react/over_react.dart';

part 'button.over_react.g.dart';

mixin ButtonPropsMixin on UiProps {}

final Button = uiFunction<ButtonPropsMixin>((props) {
  final buttonStyles = {
      'display': 'inline-block',
      'color': 'rgba(255, 255, 255, 0.75)',
      'marginBottom': '10px',
      'borderRadius': '.25rem',
      'backgroundColor': '#0075DB',
      'fontWeight': 'bold',
      'fontSize': 'smaller',
      'border': 'none',
      'padding': '10px 20px',
      'cursor': 'pointer',
      ...(props.style ?? {})
    };
  return (Dom.button()
    ..modifyProps(props.addPropsToForward(domOnly: true))
    ..style = {
      'display': 'inline-block',
      'color': 'rgba(255, 255, 255, 0.75)',
      'marginBottom': '10px',
      'borderRadius': '5px',
      'backgroundColor': '#0075DB',
      'fontWeight': 'bold',
      'fontSize': 'smaller',
      'border': 'none',
      'padding': '10px 20px',
      'cursor': 'pointer',
      'outline': 'none',
      ...(props.style ?? {})
    }
    ..onMouseOver = ((e) => setProperty(getProperty(e.currentTarget, 'style'), 'backgroundColor', 'rgb(0, 98, 184)'))
    ..onMouseLeave = ((e) => setProperty(getProperty(e.currentTarget, 'style'), 'backgroundColor', '#0075DB'))
    )(props.children);
}, _$ButtonConfig);
