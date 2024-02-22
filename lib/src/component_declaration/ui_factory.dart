import 'builder_helpers.dart' as bh;
import 'function_component.dart';
import 'props_and_state_base.dart';

/// A function that returns a new [TProps] instance, optionally backed by the specified [backingProps].
///
/// For use in wrapping existing Maps in typed getters and setters, and for creating React components
/// via a fluent-style builder interface.
typedef TProps UiFactory<TProps extends UiProps>([Map? backingProps]);

extension UiFactoryHelpers<TProps extends bh.UiProps> on UiFactory<TProps> {
  /// Generates the configuration necessary to construct a UiFactory while invoking
  /// `uiForwardRef` with a props class that has already been consumed.
  ///
  /// See `uiForwardRef` for examples and context.
  UiFactoryConfig<TProps> asForwardRefConfig({String? displayName}) => UiFactoryConfig(propsFactory: PropsFactory.fromUiFactory(this), displayName: displayName);

  /// The type of the element created by this factory.
  ///
  /// For DOM components, this will be a [String] tagName (e.g., `'div'`, `'a'`).
  ///
  /// For composite components (react-dart or pure JS), this will be a [ReactClass].
  dynamic get elementType => this().componentFactory!.type;
}
