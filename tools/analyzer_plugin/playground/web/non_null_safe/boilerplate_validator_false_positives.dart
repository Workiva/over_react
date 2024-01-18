// @dart=2.11
// This file is a non-null safe copy of playground examples to enable QAing backwards compatibility.
import 'package:over_react/over_react.dart';

// This should not be linted as "an .over_react.g.dart" part is required.
mixin SomeMixin on UiStatefulComponent2<UiProps, UiState> {}

// This should not be linted as "an .over_react.g.dart" part is required.
abstract class SomeAbstractComponent<T extends UiProps>
    extends UiComponent2<T> {}

// This should not be linted as "an .over_react.g.dart" part is required.
// ignore: deprecated_member_use_from_same_package
abstract class LegacyAbstractComponent<T extends UiProps>
    extends UiComponent<T> {}
