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

library over_react.constants;

/// A named constant with a helpful string representation.
abstract class DebugFriendlyConstant {
  /// The name of this constant, for debugging purposes only.
  final String _name;

  const DebugFriendlyConstant(this._name);

  /// A helpful description of this constant, used in [toString].
  String get debugDescription;

  @override
  String toString() => '$runtimeType.$_name ($debugDescription)';
}

/// A named constant with a helpful string representation
/// that contains a CSS class name value.
abstract class ClassNameConstant extends DebugFriendlyConstant {
  /// The CSS class name value associated with this constant.
  final String className;

  const ClassNameConstant(String name, this.className) : super(name);

  @override
  String get debugDescription => 'className: $className';
}
