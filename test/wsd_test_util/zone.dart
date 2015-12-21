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
