library guid_util;

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
