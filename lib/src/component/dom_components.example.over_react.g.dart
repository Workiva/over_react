part of 'dom_components.dart';

// -----------------------------------------------------------------------------
// ------------------------------ Generated Code -------------------------------
// -----------------------------------------------------------------------------

PropsFactory $domPropsConfig = PropsFactory(
  map: (map) => $DomPropsImpl(map),
  jsMap: (map) => _$$DomPropsImpl$JsMap(map),
);

class $DomPropsImpl extends DomProps with $DomPropsMixin {
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
  // check that those fields are present.
}


class _$$DomPropsImpl$PlainMap extends $DomPropsImpl {
  _$$DomPropsImpl$PlainMap(Map backingMap)
      : this._props = {},
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
        super._(null, backingMap) {
    this._props = backingMap ?? JsBackedMap();
  }

  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}
