// Copyright 2021 Workiva Inc.
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

import 'package:over_react/src/component_declaration/builder_helpers.dart';

/// Casts [value] to `UiFactory<T>`, which can be inferred from the surrounding context,
/// allowing you to perform casts of dynamic values without having to repeat the type
/// or worry about how formatting affects ignore comment placement.
///
/// Example:
///
/// ```dart
/// // Explicit cast
/// UiFactory<FooProps> Foo =
///    // ignore: undefined_identifier
///    _$Foo as UiFactory<FooProps>;
///
/// // This utility
/// UiFactory<FooProps> Foo = castUiFactory(_$Foo); // ignore: undefined_identifier
/// ```
///
/// Casting the generated factory is necessary because, until code generation is
/// run, the generated factory is of type `dynamic`, meaning that the following
/// code would emit an implicit_cast error (which can't be ignored as of Dart 2.9):
///
/// ```dart
/// UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier
/// ```
///
/// This works around those limitations by reducing the amount of code necessary
/// to cast the generated factory.
///
/// __NOTE:__ When declaring a component factory, using this utility is the supported
/// approach. The builder and other tooling may not work as expected without
/// using it (even with an explicit cast).
UiFactory<T> castUiFactory<T extends UiProps>(dynamic value) => value as UiFactory<T>;
