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

library test_util.zone;

import 'dart:async';

import 'package:test/test.dart';

Zone _zone;

void validateZone() {
  if (_zone == null) {
    throw 'Need to call storeZone() first.';
  }
}

/// Store the specified (or current if none is specified) zone for use in other methods in this library.
void storeZone([Zone zone]) {
  if (zone == null) {
    zone = Zone.current;
  }
  _zone = zone;
}

/// Calls [expect] in package:test/test.dart in the zone stored in [setZone].
///
/// Useful for expectations in blocks called in other zones.
void zonedExpect(actual, matcher,
    {String reason, bool verbose: false, ErrorFormatter formatter}) {
  validateZone();

  return _zone.run(() => expect(actual, matcher, verbose: verbose, formatter: formatter));
}
