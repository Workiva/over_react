import 'package:over_react/component_base.dart';

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
T castUiFactory<T extends UiFactory>(dynamic value) => value as T;
