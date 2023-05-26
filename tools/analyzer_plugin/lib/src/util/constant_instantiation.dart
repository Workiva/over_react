// Copyright 2022 Workiva Inc.
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

import 'dart:mirrors';

import 'package:analyzer/dart/constant/value.dart';

/// Uses reflection to determine which value within [values] that [object] represents,
/// and returns the matching value.
///
/// Currently only works when the fields within [T] only contain core types and not other constant classes.
T getMatchingConst<T>(DartObject object, Iterable<T> values) {
  final classMirror = reflectClass(T);
  final objectTypeName = object.type!.element!.name;
  final valueTypeName = classMirror.simpleName.name;

  if (objectTypeName != valueTypeName) {
    throw ArgumentError('Object type $objectTypeName must exactly match value type $valueTypeName');
  }

  final fields =
      classMirror.instanceMembers.values.where((m) => m.isGetter && m.isSynthetic).map((m) => m.simpleName).toList();

  // Find the value where all fields are equal:
  return values.singleWhere((value) {
    return fields.every((field) {
      // Need to use the field symbol and not it converted back from a string or it won't work
      // for private members.
      final dynamic valueFieldValue = reflect(value).getField(field).reflectee;
      final objectFieldValue = object.getField(field.name)!.toWhateverValue();
      return valueFieldValue == objectFieldValue;
    });
  });
}

extension on DartObject {
  Object? toWhateverValue() =>
      toBoolValue() ??
      toDoubleValue() ??
      toFunctionValue() ??
      toIntValue() ??
      toListValue() ??
      toMapValue() ??
      toSetValue() ??
      toStringValue() ??
      toSymbolValue() ??
      toTypeValue();
}

extension on Symbol {
  String get name => MirrorSystem.getName(this);
}
