import '../../util.dart';

class ComponentNames {
  final String _prefix;
  final String _componentName;

  factory ComponentNames(String componentName)  {
    final parts = componentName.split('.');
    if (parts.length == 1) {
      return ComponentNames._('', componentName);
    }

    return ComponentNames._('${parts[0]}.', parts.skip(1).join('.'));
  }

  ComponentNames._(this._prefix, this._componentName);

  String get componentName => '$_prefix$_componentName';

  /// Gets the generated component factory name from the component classname.
  ///
  /// Example:
  ///   Input: FooComponent
  ///   Output: $FooComponentFactory
  ///
  /// NOTE: The factory name must be public, since sub components will reference
  /// factories from super components.
  String get componentFactoryName => '$_prefix$publicGeneratedPrefix${_componentName}Factory';

  String get implName => '$_prefix$privateSourcePrefix$_componentName';
}

class TypedMapNames {
  final String _prefix;
  final String _consumerName;

  TypedMapNames._(this._prefix, this._consumerName);

  factory TypedMapNames(String consumerName)  {
    final parts = consumerName.split('.');
    if (parts.length == 1) {
      return TypedMapNames._('', consumerName);
    }

    return TypedMapNames._('${parts[0]}.', parts.skip(1).join('.'));
  }

  String get _normalizedName => _consumerName.replaceFirst(privateSourcePrefix, '');

  String get consumerName => '$_prefix$_consumerName';

  /// Converts the consumer's written props classname to the concrete props
  /// implementation's classname by adding '$' to the [privateSourcePrefix].
  ///
  /// Example:
  ///   Input: '_$FooProps'
  ///   Output: '_$$FooProps'
  ///   Input: '_$_FooProps'
  ///   Output: '_$$_FooProps'
  String get implName => '$_prefix$privateSourcePrefix\$$_normalizedName';

  /// Converts the abstract generated props/state implementation's classname
  /// into the name of its subclass that can be backed by any Map.
  ///
  /// Example:
  ///   Input: '_$$FooProps'
  ///   Output: '_$$FooProps$PlainMap'
  String get plainMapImplName => '$implName\$PlainMap';

  /// Converts the abstract generated props/state implementation's classname
  /// into the name of its subclass that can be backed by only JsMaps.
  ///
  /// Example:
  ///   Input: '_$$FooProps'
  ///   Output: '_$$FooProps$JsMap'
  String get jsMapImplName => '$implName\$JsMap';

  /// Converts the consumer's written props classname to the consumable props
  /// classname by stripping [privateSourcePrefix] from the classname.
  ///
  /// Example:
  ///   Input: '_$FooProps'
  ///   Output: 'FooProps'
  ///   Input: '_$_FooProps'
  ///   Output: '_FooProps'
  String get publicName => '$_prefix$_normalizedName';

  /// Gets the accessors mixin class from the consumer className.
  ///
  /// Example:
  ///   Input: _$FooProps
  ///   Output: _$FooPropsAccessorsMixin
  ///   Input: _$_FooProps
  ///   Output: _$_FooPropsAccessorsMixin
  String get legacyAccessorsMixinName => '$_prefix${_consumerName}AccessorsMixin';

  String get generatedMixinName => '$_prefix\$$_consumerName';

  String get publicGeneratedMetaName => '$generatedMixinName.meta';

  /// Gets the meta variable name from the public pros class name.
  ///
  /// Example:
  ///   Input: FooProps
  ///   Output: _$metaForFooProps
  String get metaConstantName => '$_prefix${privateSourcePrefix}metaFor$_normalizedName';
}
