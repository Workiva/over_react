import 'package:over_react/src/component_declaration/builder_helpers.dart';
import 'package:over_react/src/util/prop_key_util.dart' as prop_key_util;

/// Extension with methods whose typings rely on the current type [T].
extension UiPropsSelfTypedExtension<T extends UiProps> on T {
  /// Returns the key used to store the prop read within [accessProp].
  ///
  /// For example:
  /// ```dart
  /// class FooProps = UiProps with FooPropsMixin, BarPropsMixin;
  /// mixin FooPropsMixin on UiProps {
  ///   String? foo;
  /// }
  /// mixin BarPropsMixin on UiProps {
  ///   String? bar;
  /// }
  ///
  /// void example(FooProps props) {
  ///   props.getPropKey((p) => p.foo);     // 'FooPropsMixin.foo'
  ///   props.getPropKey((p) => p.bar);     // 'BarPropsMixin.bar'
  ///   props.getPropKey((p) => p.onClick); // 'onClick'
  /// }
  /// ```
  ///
  /// Similar to the top-level [prop_key_util.getPropKey] utility, but can be done on an existing
  /// props object as opposed to needing to pass in the factory, and has better generic inference
  /// before 2.18.
  ///
  /// ```dart
  /// // Top-level method
  /// getPropKey<FooProps>((p) => p.foo, Foo);
  ///
  /// // This utility:
  /// props.getPropKey((p) => p.foo);
  /// ```
  String getPropKey(void Function(T) accessProp) => '';

  /// Returns whether the prop read within [accessProp] is specified.
  ///
  /// For example:
  /// ```dart
  /// class FooProps on UiProps {
  ///   // The controlled value of the component.
  ///   String? value;
  /// }
  ///
  /// void example(FooProps props) {
  ///   final isControlled = props.containsProp((p) => p.value);
  /// }
  /// ```
  bool containsProp(void Function(T spiedView) accessProp) => containsKey(getPropKey(accessProp));

  /// Returns the value of the prop read within [accessProp] if it's specified,
  /// or the result of [orElse] otherwise.
  ///
  /// Useful for safely accessing required props in a "partial" props map that may not contain them.
  ///
  /// See also: [getRequiredPropOrNull].
  ///
  /// For example:
  /// ```dart
  /// class FooProps on UiProps {
  ///   late String requiredProp;
  /// }
  ///
  /// void example(FooProps props) {
  ///   // Unsafe: this will throw if requiredProp is not specified
  ///   final requiredProp = props.requiredProp;
  ///
  ///   final requiredPropOrDefault =
  ///       props.getRequiredProp((p) => p.requiredProp, () => 'default value');
  /// }
  /// ```
  V getRequiredProp<V>(V Function(T spiedView) accessProp, {required V Function() orElse}) {
    if (!containsProp(accessProp)) return orElse();

    // Provide a more helpful error when a non-nullable prop is specified with `null` somehow.
    assert(() {
      try {
        accessProp(this);
      } on TypeError catch (e, st) {
        final key = getPropKey(accessProp);
        final value = this[key];
        if (value == null) {
          throw AssertionError('Error reading typed prop, likely due to props map containing explicit `null` value:'
              ' `"$key": null`.\nOriginal error: $e\n$st');
        }
        rethrow;
      }
      return true;
    }());

    return accessProp(this);
  }

  /// Returns the value of the prop read within [accessProp] if it's specified, or null otherwise.
  ///
  /// Useful for safely accessing required props in a "partial" props map that may not contain them.
  ///
  /// See also: [getRequiredProp].
  ///
  /// For example:
  /// ```dart
  /// class FooProps on UiProps {
  ///   late String requiredProp;
  /// }
  ///
  /// void example(FooProps props) {
  ///   // Unsafe: this will throw if requiredProp is not specified
  ///   final requiredProp = props.requiredProp;
  ///
  ///   final requiredPropOrNull =
  ///       props.getRequiredPropOrNull((p) => p.requiredProp);
  /// }
  /// ```
  V? getRequiredPropOrNull<V>(V Function(T spiedView) accessProp) =>
      getRequiredProp(accessProp, orElse: () => null);
}
