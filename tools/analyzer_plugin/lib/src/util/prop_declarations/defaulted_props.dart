import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/over_react_builder_parsing.dart' as orbp hide TryCast;

/// Returns the defaulted props in the class component whose boilerplate uses [propsClassElement]
/// as its props class.
///
/// The implementation uses only includes simple prop assignments in that class's `defaultProps`/`getDefaultProps`.
/// See [orbp.BoilerplateComponent.defaultedPropNames] for more information.
///
/// Returns null if [propsClassElement] is not associated with a class component, or if there was a problem looking up
/// the AST that declares the props class.
///
/// Note that this only works for concrete props classes or shorthand-syntax props mixins
/// (a props class declared with just a props mixin instead of a concrete props class).
///
/// For example, given the following code:
/// ```dart
/// // Declaration 1, with shorthand props
/// UiFactory<ShorthandProps> Shorthand = castUiFactory(_$Shorthand);
/// mixin ShorthandProps on UiProps {
///   late String defaulted;
///   late String required;
/// }
/// class ShorthandComponent extends UiComponent2<ShorthandProps> {
///   get defaultProps => (newProps()..defaulted = 'some value');
/// }
///
/// // Declaration 2, with concrete props class
/// mixin SomePropsMixin on UiProps {
///   late String defaulted;
///   late String required;
/// }
/// UiFactory<ConcreteProps> Concrete = castUiFactory(_$Concrete);
/// class ConcreteProps = UiProps with SomePropsMixin;
/// class ConcreteComponent extends UiComponent2<ConcreteProps> {
///   get defaultProps => (newProps()..defaulted = 'some value');
/// }
/// ```
///
/// This function would return the following values when provided the given props elements:
///
/// - `ShorthandProps`: `{'defaulted'}`
/// - `ConcreteProps`: `{'defaulted'}`
/// - `SomePropsMixin`: `null`
Set<String>? getDefaultedPropsForComponentWithPropsClass(InterfaceElement propsClassElement) {
  // We'll use this offset to find the AST node that declares this element.
  final propsClassNameOffset = propsClassElement.nameOffset;
  if (propsClassNameOffset == -1) return null;

  // Get the AST for the file that declares propsClassElement.
  final propsClassFileSource = propsClassElement.source;
  // We don't need resolved AST, so get unresolved AST with getParsedUnit since it's faster and synchronous.
  final result = propsClassElement.library.session.getParsedUnit(propsClassFileSource.fullName);
  if (result is! ParsedUnitResult) return null;

  // Find the class component declaration that uses this props class, and return those defaulted props.
  final declarations = orbp.parseDeclarations(result.unit, null);
  for (final d in declarations) {
    if (d is orbp.ClassComponentDeclaration && d.props.either.node.name.offset == propsClassNameOffset) {
      return d.component.defaultedPropNames;
    }
    if (d is orbp.LegacyClassComponentDeclaration && d.props.node.name.offset == propsClassNameOffset) {
      return d.component.defaultedPropNames;
    }
  }

  // Either there was no class component whose boilerplate uses this props class,
  // or there was an issue matching the props class to its AST node,
  return null;
}
