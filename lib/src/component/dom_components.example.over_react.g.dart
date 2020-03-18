part of 'dom_components.dart';

// -----------------------------------------------------------------------------
// ------------------------------ Generated Code -------------------------------
// -----------------------------------------------------------------------------

PropsFactory $domPropsConfig = PropsFactory(
  map: (map) => $DomPropsImpl(map),
  jsMap: (map) => _$$DomPropsImpl$JsMap(map),
);

// NOTE: The builder should check what classes the Props class is already mixing in.
// In this case, DomProps already mixed in DomPropsMixin, so it cannot be mixed in again.
// But the builder could be flexible enough to check for that, and mix it in
// here if it's not already.
class $DomPropsImpl extends DomProps with $DomPropsMixin {
  // NOTE: typically the generated class has a private constructor with no parameters.
  // For these cases, the generated code will need to create parameters for the factory and props
  $DomPropsImpl._(factory, props) : super(factory, props);

  factory $DomPropsImpl(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$DomPropsImpl$JsMap(backingMap);
    } else {
      return _$$DomPropsImpl$PlainMap(backingMap);
    }
  }

  // NOTE: Normally we'd also need to override `isGenerated` and the props key fields.
  // However, if the consumer is creating a props class directly then we should instead
  // verify that those fields are present on the parent class (DomProps).
}


class _$$DomPropsImpl$PlainMap extends $DomPropsImpl {
  _$$DomPropsImpl$PlainMap(Map backingMap)
      : this._props = {},
        // Set the factory to null because it will be set after the instantiation
        super._(null, backingMap) {
    this._props = backingMap ?? {};
  }

  @override
  Map get props => _props;
  Map _props;
}


class _$$DomPropsImpl$JsMap extends $DomPropsImpl {
  _$$DomPropsImpl$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        // Set the factory to null because it will be set after the instantiation
        super._(null, backingMap) {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
