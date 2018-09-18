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

library over_react.guid_util;

import 'dart:math' show Random;

final Random _guidRandom = new Random();

/// Returns a random GUID with the given [length] consisting of numbers and uppercase/lowercase letters.
String generateGuid([int length = 4]) {
  const String characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

  var guid = '';
  for (var i = 0; i < length; i++) {
    guid += characters[_guidRandom.nextInt(characters.length)];
  }

  return guid;
}
