import 'package:over_react/src/component_declaration/builder_helpers.dart';

extension SafeRequiredPropAccess<T extends UiProps> on T {
  bool containsProp(void Function(T spiedView) access) {
    return containsKey(getPropKey(access));
  }

  /// Returns the value of a prop if it's specified, or the result of [orElse] otherwise.
  ///
  /// Useful for safely accessing required props in a "partial" props map that may not contain them.
  ///
  /// For example:
  /// ```dart
  /// class FooPropsMixin on UiProps {
  ///   late String requiredProp;
  /// }
  ///
  /// example(FooPropsMixin props) {
  ///   // Unsafe: this will throw if requiredProp is not specified
  ///   final requiredProp = props.requiredProp;
  ///
  ///   final requiredPropOrDefault = props.getPropOrDefault(Foo, (p) => p.requiredProp, () => 'default value')
  /// }
  ///
  /// ```
  V getRequiredProp<V>(V Function(T spiedView) access, {required V Function() orElse}) {
    return containsProp(access) ? access(this) : orElse();
  }

  V? getRequiredPropOrNull<V>(V Function(T spiedView) access) {
    return containsProp(access) ? access(this) : null;
  }
}
