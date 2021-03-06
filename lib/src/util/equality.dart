/// Returns whether maps [a] and [b] have [identical] sets of values for the same keys.
///
/// Identity is not used for `Function`s found within the maps since tear-offs are not canonicalized.
///
/// Behavior is similar to JS shallow equality.
//
// Ported from https://github.com/reduxjs/react-redux/blob/573db0bfc8d1d50fdb6e2a98bd8a7d4675fecf11/src/utils/shallowEqual.js
//
// The MIT License (MIT)
//
// Copyright (c) 2015-present Dan Abramov
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
bool propsOrStateMapsEqual(Map a, Map b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (final key in a.keys) {
    if (!b.containsKey(key)) return false;
    final bVal = b[key];
    final aVal = a[key];
    // Function tear-offs are not canonicalized so we have to do a simple
    // equality check on them instead of checking identity.
    // See: <https://github.com/dart-lang/sdk/issues/31665#issuecomment-352678783>
    if (!identical(bVal, aVal)) {
      if (!(bVal is Function && aVal is Function && bVal == aVal)) {
        return false;
      }
    }
  }
  return true;
}
