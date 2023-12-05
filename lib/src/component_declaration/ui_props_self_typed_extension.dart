import 'package:over_react/src/component_declaration/builder_helpers.dart';

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
  String getPropKey(void Function(T) accessProp) =>
      // ignore: invalid_use_of_visible_for_overriding_member
      $getPropKey((map) => accessProp(map as T));

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
  V getRequiredProp<V>(V Function(T spiedView) accessProp, {required V Function() orElse}) =>
      containsProp(accessProp) ? accessProp(this) : orElse();

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
