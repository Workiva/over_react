import 'package:meta/meta.dart';

abstract class InstanceMutationDetector {
  final Expando<Object> _digestForInstance = new Expando();

  InstanceMutationDetector();

  factory InstanceMutationDetector.lengthBased() = _LengthBasedMutationDetector;

  /// Returns whether [instance] has been mutated in a detectable way
  /// (whether [digest]) returns a different value
  /// since the last time this method was called with it.
  ///
  /// Since the kinds of mutations detected are limited and very based on
  /// the implementations [canCheck]/[digest], a `false` return value does not mean that
  /// there were no mutations; rather, that it could not be determined with certainty
  /// whether the object was mutated.
  bool check(Object instance) {
    if (canCheck(instance)) {
      final lastDigest = _digestForInstance[instance];
      final currentDigest = _digestForInstance[instance] = digest(instance);
      return lastDigest != null && lastDigest != currentDigest;
    }

    return false;
  }

  @protected
  bool canCheck(Object value);

  @protected
  Object digest(Object value);
}

/// A simple checker that flags when a Map/List value has changed
class _LengthBasedMutationDetector extends InstanceMutationDetector {
  @override
  bool canCheck(Object instance) => instance is Map || instance is Iterable;

  @override
  int digest(Object instance) {
    if (instance is Map) return instance.length;
    if (instance is Iterable) return instance.length;
    throw ArgumentError.value(instance, 'object', 'Unexpected type');
  }
}

enum MutationCheckResult { hasMutated, hasNotMutated, unknown }


main() {
  final list = [];
  final checker = InstanceMutationDetector.lengthBased();
  print(checker.check(list));
  print(checker.check(list));
  list.add('foo');
  print(checker.check(list));
  print(checker.check(list));
  list[0] = 'bar';
  print(checker.check(list));
}
