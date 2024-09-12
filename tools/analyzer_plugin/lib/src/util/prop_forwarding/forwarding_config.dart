import 'package:analyzer/dart/element/element.dart';

/// A representation of an over_react consumer's configuration of which props classes to
/// include or exclude when forwarding props.
abstract class PropForwardingConfig {
  const PropForwardingConfig();

  const factory PropForwardingConfig.all() = _PropForwardingConfig$AllExceptFor;

  const factory PropForwardingConfig.allExceptFor(Set<InterfaceElement> onlyProps) = _PropForwardingConfig$AllExceptFor;

  const factory PropForwardingConfig.only(Set<InterfaceElement> excludedProps) = _PropForwardingConfig$Only;

  /// Whether this configuration might exclude props declared in the props class [e] when forwarding.
  bool excludesProps(InterfaceElement e);

  String get debugDescription;

  @override
  toString() => '$debugDescription';
}

class _PropForwardingConfig$Only extends PropForwardingConfig {
  final Set<InterfaceElement> _onlyProps;

  const _PropForwardingConfig$Only(this._onlyProps);

  @override
  bool excludesProps(InterfaceElement e) => !_onlyProps.contains(e);

  @override
  String get debugDescription => 'only ${_onlyProps.map((e) => e.name).toSet()}';
}

class _PropForwardingConfig$AllExceptFor extends PropForwardingConfig {
  final Set<InterfaceElement> _excludedProps;

  const _PropForwardingConfig$AllExceptFor([this._excludedProps = const {}]);

  @override
  bool excludesProps(InterfaceElement e) => _excludedProps.contains(e);

  @override
  String get debugDescription => 'all except ${_excludedProps.map((e) => e.name).toSet()}';
}
