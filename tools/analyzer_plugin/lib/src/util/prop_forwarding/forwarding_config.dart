import 'package:analyzer/dart/element/element.dart';

abstract class PropForwardingConfig {
  const PropForwardingConfig();

  const factory PropForwardingConfig.all() = _PropForwardingConfig$All;

  const factory PropForwardingConfig.allExceptFor(Set<InterfaceElement> onlyProps) = _PropForwardingConfig$AllExceptFor;

  const factory PropForwardingConfig.only(Set<InterfaceElement> excludedProps) = _PropForwardingConfig$Only;

  const factory PropForwardingConfig.unresolved() = _PropForwardingConfig$Unresolved;

  bool mightExcludeClass(InterfaceElement e);

  String get debugDescription;

  @override
  toString() => '$debugDescription';
}

class _PropForwardingConfig$All extends PropForwardingConfig {
  const _PropForwardingConfig$All();

  @override
  bool mightExcludeClass(InterfaceElement e) => false;

  @override
  String get debugDescription => 'all';
}

class _PropForwardingConfig$Only extends PropForwardingConfig {
  final Set<InterfaceElement> _onlyProps;

  const _PropForwardingConfig$Only(this._onlyProps);

  @override
  bool mightExcludeClass(InterfaceElement e) => !_onlyProps.contains(e);

  @override
  String get debugDescription => 'only ${_onlyProps.map((e) => e.name).toSet()}';
}

class _PropForwardingConfig$AllExceptFor extends PropForwardingConfig {
  final Set<InterfaceElement> _excludedProps;

  const _PropForwardingConfig$AllExceptFor(this._excludedProps);

  @override
  bool mightExcludeClass(InterfaceElement e) => _excludedProps.contains(e);

  @override
  String get debugDescription => 'all except ${_excludedProps.map((e) => e.name).toSet()}';
}

class _PropForwardingConfig$Unresolved extends PropForwardingConfig {
  const _PropForwardingConfig$Unresolved();

  @override
  bool mightExcludeClass(InterfaceElement e) => false;

  @override
  String get debugDescription => 'unresolved';
}
