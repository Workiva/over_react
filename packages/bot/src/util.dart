library bot.util;

import 'dart:async' as async;

import 'require.dart';
import 'helpers.dart';

class Util {
  static int getHashCode(Iterable source) {
    requireArgumentNotNull(source, 'source');

    int hash = 0;
    for (final h in source) {
      int next = h == null ? 0 : h.hashCode;
      hash = 0x1fffffff & (hash + next);
      hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
      hash ^= hash >> 6;
    }
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    hash ^= hash >> 11;
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }

  // TODO: handles windows new lines? Should test...
  static Iterable<String> splitLines(String input) {
    requireArgumentNotNull(input, 'input');

    return new FuncEnumerable<String, String>(input,
        (v) => new StringLineIterator(v));
  }

  /**
   * Returns a [String] with a length that is at least [minWidth].
   * If [text] has a length less than [minWidth], the return value
   * will be a string with spaces inserted before [text].
   */
  static String padLeft(String text, int minWidth) {
    requireArgumentNotNull(text, 'text');
    while (text.length < minWidth) {
      text = ' ' + text;
    }
    return text;
  }
}

/**
 * Designed to allow methods to support a variety of "delayed" inputs.
 *
 * If the [input] is a [Future], [getDelayedResult] waits for a result.
 *
 * If the [input] is a [Function], [getDelayedResult] evaluates it for a result.
 *
 * The result in both cases is provided back to [getDelayedResult] evaluated again.
 *
 * If the original [input]--or once a recursive [input]--is neigther a [Future]
 * nor a [Function] that value is returned wrapped in a [Future].
 */
async.Future<dynamic> getDelayedResult(dynamic input) {
  if (input is Function) {
    input = new async.Future(input);
  }

  if (input is async.Future) {
    return input.then((value) => getDelayedResult(value));
  } else {
    return new async.Future.value(input);
  }
}
