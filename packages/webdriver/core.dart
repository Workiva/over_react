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

library webdriver.core;

import 'dart:async' show Future, Stream, StreamController;
import 'dart:collection' show UnmodifiableMapView;
import 'dart:convert' show BASE64;
import 'dart:math' show Point, Rectangle;

import 'package:stack_trace/stack_trace.dart' show Chain;

import 'src/command_processor.dart' show CommandProcessor;
import 'src/stepper.dart' show Stepper;

export 'src/exception.dart';

part 'src/alert.dart';
part 'src/capabilities.dart';
part 'src/command_event.dart';
part 'src/common.dart';
part 'src/keyboard.dart';
part 'src/logs.dart';
part 'src/mouse.dart';
part 'src/navigation.dart';
part 'src/options.dart';
part 'src/target_locator.dart';
part 'src/web_driver.dart';
part 'src/web_element.dart';
part 'src/window.dart';

final Uri defaultUri = Uri.parse('http://127.0.0.1:4444/wd/hub/');

Future<WebDriver> createDriver(CommandProcessor processor,
    {Uri uri, Map<String, dynamic> desired}) async {
  if (uri == null) {
    uri = defaultUri;
  }

  if (desired == null) {
    desired = Capabilities.empty;
  }

  Map response = await processor.post(
      uri.resolve('session'), {'desiredCapabilities': desired},
      value: false) as Map<String, dynamic>;
  return new WebDriver(processor, uri, response['sessionId'],
      new UnmodifiableMapView(response['value'] as Map<String, dynamic>));
}

Future<WebDriver> fromExistingSession(
    CommandProcessor processor, String sessionId,
    {Uri uri}) async {
  if (uri == null) {
    uri = defaultUri;
  }

  var response = await processor.get(uri.resolve('session/$sessionId'))
      as Map<String, dynamic>;
  return new WebDriver(
      processor, uri, sessionId, new UnmodifiableMapView(response));
}
