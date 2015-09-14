library guid_util;

import 'dart:math' show Random;

/// Randomly generate a GUID with the give length
/// Possibly in the future this could be replaced by the uuid lib.
String generateGuid([length = 16]) {
  Random rand = new Random();

  String guid = '';
  for (var i = 0; i < length; i++) {
    guid += rand.nextInt(100).toRadixString(16).substring(0, 1);
  }

  return guid;
}
