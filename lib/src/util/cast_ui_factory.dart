import 'package:over_react/component_base.dart';

/// Casts [value] to `UiFactory<T>`, which can be inferred from the surrounding context,
/// allowing you to perform casts of dynamic values without having to repeat the type.
///
/// Example:
///
/// ```dart
/// UiFactory<FooProps> Foo = castUiFactory(_$Foo);
/// ```
///
/// This is necessary because ungenerated members (identifiable by the `_$` prefix)
/// are considered dynamic. This requires a cast on the right hand side. However,
/// due to complications around formatting and "ignore" comments, in order to prevent
/// false positive lints or errors, there are limitations around using an explicit
/// cast (i.e. `_$Foo as UiFactory<FooProps>`).
///
/// This works around those limitations by reducing the amount of code necessary
/// to cast the generated factory.
T castUiFactory<T extends UiFactory>(dynamic value) => value as T;
