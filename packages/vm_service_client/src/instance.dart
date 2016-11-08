// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:stack_trace/stack_trace.dart';

import 'bound_field.dart';
import 'class.dart';
import 'context.dart';
import 'exceptions.dart';
import 'function.dart';
import 'object.dart';
import 'scope.dart';
import 'sentinel.dart';
import 'type_arguments.dart';
import 'utils.dart';

VMInstanceRef newVMInstanceRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Instance" || json["type"] == "Instance");
  switch (json["kind"]) {
    case "Null": return new VMNullInstanceRef._(scope, json);
    case "Bool": return new VMBoolInstanceRef._(scope, json);
    case "Double": return new VMDoubleInstanceRef._(scope, json);
    case "Int": return new VMIntInstanceRef._(scope, json);
    case "String": return new VMStringInstanceRef._(scope, json);
    case "Float32x4": return new VMFloat32x4InstanceRef._(scope, json);
    case "Float64x2": return new VMFloat64x2InstanceRef._(scope, json);
    case "Int32x4": return new VMInt32x4InstanceRef._(scope, json);
    case "StackTrace": return new VMStackTraceInstanceRef._(scope, json);
    case "List": return new VMListInstanceRef._(scope, json);
    case "Map": return new VMMapInstanceRef._(scope, json);
    case "Uint8ClampedList":
      return new VMTypedDataInstanceRef<Uint8ClampedList>._(scope, json);
    case "Uint8List":
      return new VMTypedDataInstanceRef<Uint8List>._(scope, json);
    case "Uint16List":
      return new VMTypedDataInstanceRef<Uint16List>._(scope, json);
    case "Uint32List":
      return new VMTypedDataInstanceRef<Uint32List>._(scope, json);
    case "Uint64List":
      return new VMTypedDataInstanceRef<Uint64List>._(scope, json);
    case "Int8List":
      return new VMTypedDataInstanceRef<Int8List>._(scope, json);
    case "Int16List":
      return new VMTypedDataInstanceRef<Int16List>._(scope, json);
    case "Int32List":
      return new VMTypedDataInstanceRef<Int32List>._(scope, json);
    case "Int64List":
      return new VMTypedDataInstanceRef<Int64List>._(scope, json);
    case "Float32List":
      return new VMTypedDataInstanceRef<Float32List>._(scope, json);
    case "Float64List":
      return new VMTypedDataInstanceRef<Float64List>._(scope, json);
    case "Int32x4List":
      return new VMTypedDataInstanceRef<Int32x4List>._(scope, json);
    case "Float32x4List":
      return new VMTypedDataInstanceRef<Float32x4List>._(scope, json);
    case "Float64x2List":
      return new VMTypedDataInstanceRef<Float64x2List>._(scope, json);
    case "Closure": return new VMClosureInstanceRef._(scope, json);
    case "MirrorReference":
      return new VMMirrorReferenceInstanceRef._(scope, json);
    case "RegExp": return new VMRegExpInstanceRef._(scope, json);
    case "WeakProperty": return new VMWeakPropertyInstanceRef._(scope, json);
    case "Type": return new VMTypeInstanceRef._(scope, json);
    case "TypeParameter": return new VMTypeParameterInstanceRef._(scope, json);
    case "TypeRef": return new VMTypeRefInstanceRef._(scope, json);
    case "BoundedType": return new VMBoundedTypeInstanceRef._(scope, json);
    default:
      // The VM service protocol specifies that unknown instance kinds are to be
      // treated as plain instances.
      return new VMInstanceRef._(scope, json);
  }
}

VMInstanceRef newVMInstance(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "Instance");
  switch (json["kind"]) {
    case "Null": return new VMNullInstance._(scope, json);
    case "Bool": return new VMBoolInstance._(scope, json);
    case "Double": return new VMDoubleInstance._(scope, json);
    case "Int": return new VMIntInstance._(scope, json);
    case "String": return new VMStringInstance._(scope, json);
    case "Float32x4": return new VMFloat32x4Instance._(scope, json);
    case "Float64x2": return new VMFloat64x2Instance._(scope, json);
    case "Int32x4": return new VMInt32x4Instance._(scope, json);
    case "StackTrace": return new VMStackTraceInstance._(scope, json);
    case "List": return new VMListInstance._(scope, json);
    case "Map": return new VMMapInstance._(scope, json);
    case "Uint8ClampedList":
    case "Uint8List":
    case "Uint16List":
    case "Uint32List":
    case "Uint64List":
    case "Int8List":
    case "Int16List":
    case "Int32List":
    case "Int64List":
    case "Float32List":
    case "Float64List":
    case "Int32x4List":
    case "Float32x4List":
    case "Float64x2List":
      return new VMTypedDataInstance._(scope, json);
    case "Closure": return new VMClosureInstance._(scope, json);
    case "MirrorReference":
      return new VMMirrorReferenceInstance._(scope, json);
    case "RegExp": return new VMRegExpInstance._(scope, json);
    case "WeakProperty": return new VMWeakPropertyInstance._(scope, json);
    case "Type": return new VMTypeInstance._(scope, json);
    case "TypeParameter": return new VMTypeParameterInstance._(scope, json);
    case "TypeRef": return new VMTypeRefInstance._(scope, json);
    case "BoundedType": return new VMBoundedTypeInstance._(scope, json);
    default:
      // The VM service protocol specifies that unknown instance kinds are to be
      // treated as plain instances.
      return new VMInstance._(scope, json);
  }
}

VMTypeLikeInstanceRef newVMTypeLikeInstanceRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Instance" || json["type"] == "Instance");
  switch (json["kind"]) {
    case "Type": return new VMTypeInstanceRef._(scope, json);
    case "TypeParameter": return new VMTypeParameterInstanceRef._(scope, json);
    case "TypeRef": return new VMTypeRefInstanceRef._(scope, json);
    case "BoundedType": return new VMBoundedTypeInstanceRef._(scope, json);
    default:
      throw new StateError('Unknown Type-like kind "${json["kind"]}".');
  }
}

VMTypeInstanceRef newVMTypeInstanceRef(Scope scope,
    Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Instance" || json["type"] == "Instance");
  assert(json["kind"] == "Type");
  return new VMTypeInstanceRef._(scope, json);
}

newVMInstanceRefOrSentinel(Scope scope, Map json) {
  if (json == null) return null;
  if (json["type"] == "Sentinel") return newVMSentinel(json);
  return newVMInstanceRef(scope, json);
}

/// A reference to an instance of a Dart class on the remote VM.
///
/// Note that subclasses of this like [List] and [Map] will only be used for the
/// built-in implementations of those classes. User-defined implementations will
/// be plain [VMInstanceRef]s or [VMInstance]s instead.
class VMInstanceRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for this instance, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service
  /// instance objects that refer to the same instance.
  final bool _fixedId;

  final VMClassRef klass;

  VMInstanceRef._(Scope scope, Map json)
      : _scope = scope,
        _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        klass = newVMClassRef(scope, json["class"]);

  /// Returns a local Dart copy of the remote Dart object.
  ///
  /// This creates a copy of all copyable objects with corresponding
  /// [VMInstanceRef] subclasses. If an uncopyable or unknown instance is
  /// encountered, an [UnsupportedError] is thrown. If an instance has exired, a
  /// [VMSentinelException] is thrown.
  ///
  /// If [onUnknownValue] is provided, it's called with any uncopyable instances
  /// or sentinels that are encountered. Its return value is used as the value
  /// of that instance or sentinel. It may return a [Future], in which case the
  /// completion value of the future is used.
  ///
  /// This is safe to use with object graphs that contain loops. Within the
  /// scope of a call to [getValue], including within calls to [onUnknownValue],
  /// return values are cached, so multiple calls to [getValue] for the same
  /// instance will return identical Dart objects.
  Future<Object> getValue({onUnknownValue(value)}) async {
    if (Zone.current[#_cache] != null) return _getValue(onUnknownValue);
    return runZoned(() => _getValue(onUnknownValue),
        zoneValues: {#_cache: {}});
  }

  /// A helper method for [getValue] that doesn't try to create a new cache.
  Future<Object> _getValue(onUnknownValue(value)) async {
    var cache = Zone.current[#_cache];

    if (!cache.containsKey(this)) {
      if (onUnknownValue != null) {
        cache[this] = await onUnknownValue(this);
      } else {
        throw new UnsupportedError(
            "Can't get the value of a ${klass.name} instance.");
      }
    }

    return cache[this];
  }

  Future<VMInstance> load() async =>
      new VMInstance._(_scope, await _load());

  /// Evaluates [expression] in the context of this instance.
  ///
  /// Throws a [VMErrorException] if evaluating the expression throws an error.
  /// Throws a [VMSentinelException] if this instance has expired.
  Future<VMInstanceRef> evaluate(String expression) =>
      _scope.evaluate(_id, expression);

  Future<Map> _load() => _scope.loadObject(_id);

  bool operator ==(other) => other is VMInstanceRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() => "Remote instance of '${klass.name}'";
}

/// An instance of a Dart class on the remote VM.
class VMInstance extends VMInstanceRef implements VMObject {
  final int size;

  /// The instance's fields.
  final Map<String, VMBoundField> fields;

  VMInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

// Value objects

/// A reference to an instance whose value is synchronously accessible via
/// the reference.
abstract class VMValueInstanceRef<T> extends VMInstanceRef {
  /// The value as a local Dart instance.
  T get value;

  VMValueInstanceRef._(Scope scope, Map json)
      : super._(scope, json);

  Future<VMValueInstance<T>> load();

  Future<T> getValue({onUnknownValue(value)}) =>
      super.getValue(onUnknownValue: onUnknownValue);

  Future<T> _getValue(onUnknownValue(value)) async => value;

  String toString() => value.toString();
}

/// An instance whose value is synchronously accessible via the reference.
abstract class VMValueInstance<T>
    implements VMValueInstanceRef<T>, VMInstance {
}

/// A reference to a `null` instance.
class VMNullInstanceRef extends VMValueInstanceRef<Null> {
  Null get value => null;

  VMNullInstanceRef._(Scope scope, Map json)
      : super._(scope, json);

  Future<VMNullInstance> load() async =>
      new VMNullInstance._(_scope, await _load());
}

/// A `null` instance.
class VMNullInstance extends VMNullInstanceRef
    implements VMValueInstance<Null> {
  final int size;

  final Map<String, VMBoundField> fields;

  VMNullInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

/// A reference to an instance of [bool].
class VMBoolInstanceRef extends VMValueInstanceRef<bool> {
  final bool value;

  VMBoolInstanceRef._(Scope scope, Map json)
      : value = json["valueAsString"] == "true",
        super._(scope, json);

  Future<VMBoolInstance> load() async =>
      new VMBoolInstance._(_scope, await _load());
}

/// An instance of [bool].
class VMBoolInstance extends VMBoolInstanceRef
    implements VMValueInstance<bool> {
  final int size;

  final Map<String, VMBoundField> fields;

  VMBoolInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

/// A reference to an instance of [double].
class VMDoubleInstanceRef extends VMValueInstanceRef<double> {
  final double value;

  VMDoubleInstanceRef._(Scope scope, Map json)
      : value = double.parse(json["valueAsString"]),
        super._(scope, json);

  Future<VMDoubleInstance> load() async =>
      new VMDoubleInstance._(_scope, await _load());
}

/// An instance of [double].
class VMDoubleInstance extends VMDoubleInstanceRef
    implements VMValueInstance<double> {
  final int size;

  final Map<String, VMBoundField> fields;

  VMDoubleInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

/// A reference to an instance of [int].
class VMIntInstanceRef extends VMValueInstanceRef<int> {
  final int value;

  /// The string representation of [value].
  ///
  /// When compiled to JS, the [int] type is limited to 53 bits, but on the Dart
  /// VM ints are unbounded. When dealing with ints of an unknown size in code
  /// that may run on a browser, this should be used for maximum portability.
  final String valueAsString;

  VMIntInstanceRef._(Scope scope, Map json)
      : valueAsString = json["valueAsString"],
        value = int.parse(json["valueAsString"]),
        super._(scope, json);

  Future<VMIntInstance> load() async =>
      new VMIntInstance._(_scope, await _load());

  String toString() => valueAsString;
}

/// An instance of [int].
class VMIntInstance extends VMIntInstanceRef implements VMValueInstance<int> {
  final int size;

  final Map<String, VMBoundField> fields;

  VMIntInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

/// A reference to an instance of [Float32x4].
class VMFloat32x4InstanceRef extends VMValueInstanceRef<Float32x4> {
  final Float32x4 value;

  VMFloat32x4InstanceRef._(Scope scope, Map json)
      : value = _parse(json["valueAsString"]),
        super._(scope, json);

  /// Parses the [Float32x4] from the string representation of value, which is
  /// of the form "[W, X, Y, Z]" where W, X, Y, and Z are floats.
  static Float32x4 _parse(String value) {
    var lanes = value
         // Substring to get rid of the surrounding [ and ].
        .substring(1, value.length - 1)
        .split(",")
        .map(double.parse)
        .toList();
    return new Float32x4(lanes[0], lanes[1], lanes[2], lanes[3]);
  }

  Future<Float32x4> _getValue(onUnknownValue(value)) async => value;

  Future<VMFloat32x4Instance> load() async =>
      new VMFloat32x4Instance._(_scope, await _load());
}

/// An instance of [Float32x4].
class VMFloat32x4Instance extends VMFloat32x4InstanceRef
    implements VMValueInstance<Float32x4> {
  final int size;

  final Map<String, VMBoundField> fields;

  VMFloat32x4Instance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

/// An instance of [Float64x2].
class VMFloat64x2InstanceRef extends VMValueInstanceRef<Float64x2> {
  final Float64x2 value;

  VMFloat64x2InstanceRef._(Scope scope, Map json)
      : value = _parse(json["valueAsString"]),
        super._(scope, json);

  /// Parses the [Float64x2] from the string representation of value, which is
  /// of the form "[X, Y]" where X and Y are floats.
  static Float64x2 _parse(String value) {
    var lanes = value
         // Substring to get rid of the surrounding [ and ].
        .substring(1, value.length - 1)
        .split(",")
        .map(double.parse)
        .toList();
    return new Float64x2(lanes[0], lanes[1]);
  }

  Future<VMFloat64x2Instance> load() async =>
      new VMFloat64x2Instance._(_scope, await _load());
}

/// An instance of [Float64x2].
class VMFloat64x2Instance extends VMFloat64x2InstanceRef
    implements VMValueInstance<Float64x2> {
  final int size;

  final Map<String, VMBoundField> fields;

  VMFloat64x2Instance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

/// A reference to an instance of [Int32x4].
class VMInt32x4InstanceRef extends VMValueInstanceRef<Int32x4> {
  final Int32x4 value;

  VMInt32x4InstanceRef._(Scope scope, Map json)
      : value = _parse(json["valueAsString"]),
        super._(scope, json);

  /// Parses the [Int32x4] from the string representation of value, which is
  /// of the form "[M, N, P, Q]" where N, M, P, and Q are integers.
  static Int32x4 _parse(String value) {
    var lanes = value
         // Substring to get rid of the surrounding [ and ].
        .substring(1, value.length - 1)
        .split(",")
        .map((lane) => int.parse(lane, radix: 16))
        .toList();
    return new Int32x4(lanes[0], lanes[1], lanes[2], lanes[3]);
  }

  Future<VMInt32x4Instance> load() async =>
      new VMInt32x4Instance._(_scope, await _load());
}

/// An instance of [Int32x4].
class VMInt32x4Instance extends VMInt32x4InstanceRef
    implements VMValueInstance<Int32x4> {
  final int size;

  final Map<String, VMBoundField> fields;

  VMInt32x4Instance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

class VMStackTraceInstanceRef extends VMValueInstanceRef<StackTrace> {
  final Trace value;

  VMStackTraceInstanceRef._(Scope scope, Map json)
      : value = new Trace.parseVM(json["valueAsString"]),
        super._(scope, json);

  Future<VMStackTraceInstance> load() async =>
      new VMStackTraceInstance._(_scope, await _load());
}

class VMStackTraceInstance extends VMStackTraceInstanceRef
    implements VMValueInstance<StackTrace> {
  final int size;

  final Map<String, VMBoundField> fields;

  VMStackTraceInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);
}

// Instances of userspace Dart classes

/// A reference to an instance of [String].
class VMStringInstanceRef extends VMInstanceRef {
  /// Note that the value of a reference to a string may be truncated for long
  /// strings. If so, [isValueTruncated] will be `true`, and the full value can
  /// be accessed using [getValue] or [VMStringInstance.value].
  final String value;

  /// Whether [value] is truncated for being too long.
  final bool isValueTruncated;

  VMStringInstanceRef._(Scope scope, Map json)
      : value = json["valueAsString"],
        isValueTruncated = json["valueAsStringIsTruncated"] ?? false,
        super._(scope, json);

  Future<String> _getValue(onUnknownValue(value)) async {
    try {
      return (await load()).value;
    } on VMSentinelException catch (error) {
      if (onUnknownValue != null) return onUnknownValue(error.sentinel);
      rethrow;
    }
  }

  Future<VMStringInstance> load() async =>
      new VMStringInstance._(_scope, await _load());

  String toString() {
    var contents = isValueTruncated ? "$value..." : value;
    return '"' + escapeString(contents).replaceAll('"', '\\"') + '"';
  }
}

/// An instance of [String].
class VMStringInstance extends VMStringInstanceRef implements VMInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  VMStringInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        super._(scope, json);

  Future<String> _getValue(onUnknownValue(value)) async => value;
}

/// A reference to an instance of [List].
class VMListInstanceRef extends VMInstanceRef {
  /// The length of the list.
  final int length;

  VMListInstanceRef._(Scope scope, Map json)
      : length = json["length"],
        super._(scope, json);

  Future<List> _getValue(onUnknownValue(value)) async {
    try {
      return (await load())._getValue(onUnknownValue);
    } on VMSentinelException catch (error) {
      if (onUnknownValue != null) return onUnknownValue(error.sentinel);
      rethrow;
    }
  }

  Future<VMListInstance> load() async =>
      new VMListInstance._(_scope, await _load());

  String toString() => "[...]";
}

/// An instance of [List].
class VMListInstance extends VMListInstanceRef implements VMInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  /// The elements of the list.
  ///
  /// Each element is either a [VMInstanceRef] or a [VMSentinel], indicating
  /// that the value has expired.
  final List elements;

  VMListInstance._(Scope scope, Map json)
      : size = json["size"],
        elements = new List.unmodifiable(json["elements"]
            .map((element) => newVMInstanceRefOrSentinel(scope, element))),
        fields = _fields(scope, json),
        super._(scope, json);

  Future<List> _getValue(onUnknownValue(value)) async {
    var cache = Zone.current[#_cache];
    if (cache.containsKey(this)) return cache[this];

    var list = [];
    cache[this] = list;

    await Future.wait(elements.map((element) async {
      if (element is VMInstanceRef) {
        list.add(await element._getValue(onUnknownValue));
      } else if (onUnknownValue != null) {
        list.add(await onUnknownValue(element));
      } else {
        throw new VMSentinelException(element);
      }
    }), eagerError: true);

    return list;
  }

  String toString() => "[${elements.join(", ")}]";
}

/// A reference to an instance of [Map].
class VMMapInstanceRef extends VMInstanceRef {
  /// The length of the map.
  final int length;

  VMMapInstanceRef._(Scope scope, Map json)
      : length = json["length"],
        super._(scope, json);

  Future<Map> _getValue(onUnknownValue(value)) async {
    try {
      return (await load())._getValue(onUnknownValue);
    } on VMSentinelException catch (error) {
      if (onUnknownValue != null) return onUnknownValue(error.sentinel);
      rethrow;
    }
  }

  Future<VMMapInstance> load() async =>
      new VMMapInstance._(_scope, await _load());

  String toString() => "{...}";
}

/// An instance of [Map].
class VMMapInstance extends VMMapInstanceRef implements VMInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  /// The key/value pairs in the map.
  final List<VMMapAssociation> associations;

  VMMapInstance._(Scope scope, Map json)
      : size = json["size"],
        associations = new List.unmodifiable(json["associations"]
            .map((element) => new VMMapAssociation._(scope, element))),
        fields = _fields(scope, json),
        super._(scope, json);

  Future<Map> _getValue(onUnknownValue(value)) async {
    var cache = Zone.current[#_cache];
    if (cache.containsKey(this)) return cache[this];

    var map = {};
    cache[this] = map;

    await Future.wait(associations.map((association) async {
      var results = await Future.wait(
          [association.key, association.value].map((value) {
        if (value is VMInstanceRef) {
          return value._getValue(onUnknownValue);
        } else if (onUnknownValue != null) {
          return onUnknownValue(value);
        } else {
          throw new VMSentinelException(value);
        }
      }), eagerError: true);
      map[results.first] = results.last;
    }), eagerError: true);

    return map;
  }

  String toString() => "{${associations.join(", ")}}";
}

/// A single key/value pair in a [VMMapInstance].
class VMMapAssociation {
  /// The key.
  ///
  /// This is either a [VMInstance] or a [VMSentinel], indicating that the key
  /// has expired.
  final key;

  /// The value.
  ///
  /// This is either a [VMInstance] or a [VMSentinel], indicating that the value
  /// has expired.
  final value;

  VMMapAssociation._(scope, json)
      : key = newVMInstanceRefOrSentinel(scope, json["key"]),
        value = newVMInstanceRefOrSentinel(scope, json["value"]);

  String toString() => "$key: $value";
}

/// A reference to an instance of [TypedData].
class VMTypedDataInstanceRef<T extends TypedData> extends VMInstanceRef {
  /// The length of the data.
  final int length;

  /// The length of the data in bytes.
  final int lengthInBytes;

  VMTypedDataInstanceRef._(Scope scope, Map json)
      : length = json["length"],
        lengthInBytes = json["length"] * _bytesPerValue(json["kind"]),
        super._(scope, json);

  /// Returns the number of bytes each element takes up for the typed data kind
  /// [kind].
  static int _bytesPerValue(String kind) {
    switch (kind) {
      case "Uint8ClampedList":
      case "Uint8List":
      case "Int8List":
        return 8;
      case "Uint16List":
      case "Int16List":
        return 16;
      case "Uint32List":
      case "Int32List":
      case "Float32List":
        return 32;
      case "Uint64List":
      case "Int64List":
      case "Float64List":
        return 64;
      case "Int32x4List":
      case "Float32x4List":
      case "Float64x2List":
        return 128;
      default:
        throw new StateError('Unknown TypedData kind "$kind".');
    }
  }

  Future<T> _getValue(onUnknownValue(value)) async {
    try {
      return (await load())._getValue(onUnknownValue);
    } on VMSentinelException catch (error) {
      if (onUnknownValue != null) return onUnknownValue(error.sentinel);
      rethrow;
    }
  }

  Future<VMTypedDataInstance<T>> load() async =>
      new VMTypedDataInstance._(_scope, await _load());

  String toString() => "[...]";
}

/// An instance of [TypedData].
class VMTypedDataInstance<T extends TypedData> extends VMTypedDataInstanceRef<T>
    implements VMInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  /// A local copy of the value of the data.
  final T value;

  VMTypedDataInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        value = _value(json),
        super._(scope, json);

  static TypedData _value(Map json) {
    var byteList = BASE64.decode(json["bytes"]);
    var bytes = byteList is TypedData
        ? byteList
        : new Uint8List.fromList(byteList);

    switch (json["kind"]) {
      case "Uint8ClampedList": return bytes.buffer.asUint8ClampedList();
      case "Uint8List": return bytes.buffer.asUint8List();
      case "Uint16List": return bytes.buffer.asUint16List();
      case "Uint32List": return bytes.buffer.asUint32List();
      case "Uint64List": return bytes.buffer.asUint64List();
      case "Int8List": return bytes.buffer.asInt8List();
      case "Int16List": return bytes.buffer.asInt16List();
      case "Int32List": return bytes.buffer.asInt32List();
      case "Int64List": return bytes.buffer.asInt64List();
      case "Float32List": return bytes.buffer.asFloat32List();
      case "Float64List": return bytes.buffer.asFloat64List();
      case "Int32x4List": return bytes.buffer.asInt32x4List();
      case "Float32x4List": return bytes.buffer.asFloat32x4List();
      case "Float64x2List": return bytes.buffer.asFloat64x2List();
      default:
        throw new StateError('Unknown TypedData kind "${json["kind"]}".');
    }
  }

  Future<T> _getValue(onUnknownValue(value)) async => value;

  String toString() => value.toString();
}

/// A reference to an instance of [RegExp].
///
/// Note that [getValue] is only guaranteed to be accurate in version 3.0 and
/// later of the VM service protocol. In previous version, there was no way to
/// get the values of the [RegExp.isCaseSensitive] and [RegExp.isMultiLine]
/// flags.
class VMRegExpInstanceRef extends VMInstanceRef {
  /// The RegExp's pattern.
  final VMStringInstanceRef pattern;

  VMRegExpInstanceRef._(Scope scope, Map json)
      : pattern = new VMStringInstanceRef._(scope, json["pattern"]),
        super._(scope, json);

  Future<RegExp> _getValue(onUnknownValue(value)) async {
    try {
      return (await load())._getValue(onUnknownValue);
    } on VMSentinelException catch (error) {
      if (onUnknownValue != null) return onUnknownValue(error.sentinel);
      rethrow;
    }
  }

  Future<VMRegExpInstance> load() async =>
      new VMRegExpInstance._(_scope, await _load());

  String toString() => pattern.toString();
}

/// An instance of [RegExp].
class VMRegExpInstance extends VMRegExpInstanceRef implements VMInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  /// Whether the RegExp is case-sensitive.
  ///
  /// This is only guaranteed to be accurate in version 3.0 and later of the VM
  /// service protocol
  final bool isCaseSensitive;

  /// Whether the RegExp is multi-line-aware.
  ///
  /// This is only guaranteed to be accurate in version 3.0 and later of the VM
  /// service protocol
  final bool isMultiLine;

  VMRegExpInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        isCaseSensitive = json["isCaseSensitive"] ?? true,
        isMultiLine = json["isMultiLine"] ?? false,
        super._(scope, json);

  Future<RegExp> _getValue(onUnknownValue(value)) async {
    var value = pattern.isValueTruncated
        ? (await pattern.load()).value
        : pattern.value;
    return new RegExp(value,
        multiLine: isMultiLine, caseSensitive: isCaseSensitive);
  }
}

// Internal VM objects

/// A reference to an instance of the built-in VM closure implementation.
class VMClosureInstanceRef extends VMInstanceRef {
  VMClosureInstanceRef._(Scope scope, Map json)
      : super._(scope, json);

  Future<VMClosureInstance> load() async =>
      new VMClosureInstance._(_scope, await _load());
}

/// An instance of the built-in VM closure implementation.
class VMClosureInstance extends VMClosureInstanceRef implements VMInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  /// The function associated with this closure.
  final VMFunctionRef function;

  /// The context of this closure.
  ///
  /// This contains the variables captures by the closure.
  final VMContextRef context;

  VMClosureInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        function = newVMFunctionRef(scope, json["closureFunction"]),
        context = newVMContextRef(scope, json["closureContext"]),
        super._(scope, json);
}

/// A reference to an instance of the VM-internal MirrorReference class.
class VMMirrorReferenceInstanceRef extends VMInstanceRef {
  VMMirrorReferenceInstanceRef._(Scope scope, Map json)
      : super._(scope, json);

  Future<VMMirrorReferenceInstance> load() async =>
      new VMMirrorReferenceInstance._(_scope, await _load());
}

/// An instance of the VM-internal MirrorReference class.
class VMMirrorReferenceInstance extends VMMirrorReferenceInstanceRef
    implements VMInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  final VMInstanceRef referent;

  VMMirrorReferenceInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        referent = newVMInstanceRef(scope, json["mirrorReferent"]),
        super._(scope, json);
}

/// A reference to an instance of the VM-internal WeakProperty class.
class VMWeakPropertyInstanceRef extends VMInstanceRef {
  VMWeakPropertyInstanceRef._(Scope scope, Map json)
      : super._(scope, json);

  Future<VMWeakPropertyInstance> load() async =>
      new VMWeakPropertyInstance._(_scope, await _load());
}

/// An instance of the VM-internal WeakProperty class.
class VMWeakPropertyInstance extends VMWeakPropertyInstanceRef
    implements VMInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  final VMInstanceRef key;
  final VMInstanceRef value;

  VMWeakPropertyInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        key = newVMInstanceRef(scope, json["propertyKey"]),
        value = newVMInstanceRef(scope, json["propertyValue"]),
        super._(scope, json);
}

/// A reference to an instance that's used as a type.
abstract class VMTypeLikeInstanceRef extends VMInstanceRef {
  VMTypeLikeInstanceRef._(Scope scope, Map json)
      : super._(scope, json);

  Future<VMTypeLikeInstance> load();
}

/// An instance that's used as a type.
abstract class VMTypeLikeInstance
    implements VMTypeLikeInstanceRef, VMInstance {}

/// A reference to an instance of [Type].
class VMTypeInstanceRef extends VMTypeLikeInstanceRef {
  /// The name of the type.
  final String name;
  final VMClassRef typeClass;

  VMTypeInstanceRef._(Scope scope, Map json)
      : name = json["name"],
        typeClass = newVMClassRef(scope, json["typeClass"]),
        super._(scope, json);

  Future<VMTypeInstance> load() async =>
      new VMTypeInstance._(_scope, await _load());

  String toString() => name;
}

/// An instance of [Type].
class VMTypeInstance extends VMTypeInstanceRef implements VMTypeLikeInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  /// The type arguments for this type.
  ///
  /// This will be empty unless this is an instantiated generic type.
  final VMTypeArgumentsRef arguments;

  VMTypeInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        arguments = newVMTypeArgumentsRef(scope, json["typeArguments"]),
        super._(scope, json);
}

/// A reference to an instance of the VM-internal TypeParameter class.
class VMTypeParameterInstanceRef extends VMTypeLikeInstanceRef {
  final VMClassRef parameterizedClass;

  VMTypeParameterInstanceRef._(Scope scope, Map json)
      : parameterizedClass = newVMClassRef(scope, json["parameterizedClass"]),
        super._(scope, json);

  Future<VMTypeParameterInstance> load() async =>
      new VMTypeParameterInstance._(_scope, await _load());

  String toString() => "?";
}

/// An instance of the VM-internal TypeParameter class.
class VMTypeParameterInstance extends VMTypeParameterInstanceRef
    implements VMTypeLikeInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  final int index;

  VMTypeParameterInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        index = json["index"],
        super._(scope, json);
}

/// A reference to an instance of the VM-internal TypeRef class.
class VMTypeRefInstanceRef extends VMTypeLikeInstanceRef {
  VMTypeRefInstanceRef._(Scope scope, Map json)
      : super._(scope, json);

  Future<VMTypeRefInstance> load() async =>
      new VMTypeRefInstance._(_scope, await _load());
}

/// An instance of the VM-internal TypeRef class.
class VMTypeRefInstance extends VMTypeRefInstanceRef
    implements VMTypeLikeInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  final VMTypeLikeInstanceRef referent;

  VMTypeRefInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        referent = newVMTypeLikeInstanceRef(scope, json["targetType"]),
        super._(scope, json);
}

/// A reference to an instance of the VM-internal BoundedType class.
class VMBoundedTypeInstanceRef extends VMTypeLikeInstanceRef {
  VMBoundedTypeInstanceRef._(Scope scope, Map json)
      : super._(scope, json);

  Future<VMBoundedTypeInstance> load() async =>
      new VMBoundedTypeInstance._(_scope, await _load());
}

/// An instance of the VM-internal BoundedType class.
class VMBoundedTypeInstance extends VMBoundedTypeInstanceRef
    implements VMTypeLikeInstance {
  final int size;

  final Map<String, VMBoundField> fields;

  final VMTypeLikeInstanceRef bounded;

  VMBoundedTypeInstance._(Scope scope, Map json)
      : size = json["size"],
        fields = _fields(scope, json),
        bounded = newVMTypeLikeInstanceRef(scope, json["targetType"]),
        super._(scope, json);
}

/// Returns a map that provides access to the internal fields of an `Instance`
/// described by [json].
Map<String, VMBoundField> _fields(Scope scope, Map json) {
  if (json["fields"] == null) return const {};
  return new UnmodifiableMapView(new Map.fromIterable(json["fields"],
      key: (field) => field["decl"]["name"],
      value: (field) => newVMBoundField(scope, field)));
}
