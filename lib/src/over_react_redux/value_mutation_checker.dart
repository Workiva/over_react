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

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

abstract class InstanceHasher {
  static final Expando<Object> _hashForInstance = Expando();

  const InstanceHasher();

  /// Returns whether the [hash] for [instance] has changed
  /// since the last time this method was called with it.
  ///
  /// Returns false if hashing [instance] isn't supported,
  /// as determined by [canHash].
  bool hasHashChanged(Object instance) {
    if (canHash(instance)) {
      final last = _hashForInstance[instance];
      final current = _hashForInstance[instance] = hash(instance);
      return last != null && last != current;
    }

    return false;
  }

  @protected
  bool canHash(Object value);

  @protected
  Object hash(Object value);
}

class CollectionLengthHasher extends InstanceHasher {
  const CollectionLengthHasher();

  @override
  bool canHash(Object instance) => instance is Map || instance is Iterable;

  @override
  int hash(Object instance) {
    if (instance is Map) return instance.length;
    if (instance is Iterable) return instance.length;
    throw ArgumentError.value(instance, 'object', 'Unexpected type');
  }
}

class CollectionShallowHasher extends InstanceHasher {
  const CollectionShallowHasher();

  @override
  bool canHash(Object instance) => instance is Map || instance is Iterable;

  @override
  int hash(Object instance) {
    if (instance is Map) return const MapEquality().hash(instance);
    // Don't use IterableEquality for sets, since the order affects the output.
    if (instance is Set) return const SetEquality().hash(instance);
    if (instance is Iterable) return const IterableEquality().hash(instance);
    throw ArgumentError.value(instance, 'object', 'Unexpected type');
  }
}
