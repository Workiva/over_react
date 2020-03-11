import 'package:meta/meta.dart';

import '../../util.dart';

class ComponentNames {
  final String prefix;
  final String componentName;

  factory ComponentNames(String componentName)  {
    final parts = componentName.split('.');
    if (parts.length == 1) {
      return ComponentNames._('', componentName);
    }

    return ComponentNames._('${parts[0]}.', parts.skip(1).join('.'));
  }

  ComponentNames._(this.prefix, this.componentName);

  /// Gets the generated component factory name from the component classname.
  ///
  /// Example:
  ///   Input: FooComponent
  ///   Output: $FooComponentFactory
  ///
  /// NOTE: The factory name must be public, since sub components will reference
  /// factories from super components.
  String get componentFactoryName => '$prefix$publicGeneratedPrefix${componentName}Factory';

  String get implName => '$prefix$privateSourcePrefix$componentName';
}

class AccessorNames {
  final String prefix;
  final String consumerName;

  AccessorNames._(this.prefix, this.consumerName);

  factory AccessorNames({@required String consumerName})  {
    final parts = consumerName.split('.');
    if (parts.length == 1) {
      return AccessorNames._('', consumerName);
    }

    return AccessorNames._('${parts[0]}.', parts.skip(1).join('.'));
  }

  String get _normalizedName => consumerName.replaceFirst(privateSourcePrefix, '');

  /// Converts the consumer's written props classname to the concrete props
  /// implementation's classname by adding '$' to the [privateSourcePrefix].
  ///
  /// Example:
  ///   Input: '_$FooProps'
  ///   Output: '_$$FooProps'
  ///   Input: '_$_FooProps'
  ///   Output: '_$$_FooProps'
  String get implName => '$prefix$privateSourcePrefix\$$_normalizedName';

  /// Converts the abstract generated props/state implementation's classname
  /// into the name of its subclass that can be backed by any Map.
  ///
  /// Example:
  ///   Input: '_$$FooProps'
  ///   Output: '_$$FooProps$PlainMap'
  String get plainMapImplName => '$prefix$implName\$PlainMap';

  /// Converts the abstract generated props/state implementation's classname
  /// into the name of its subclass that can be backed by only JsMaps.
  ///
  /// Example:
  ///   Input: '_$$FooProps'
  ///   Output: '_$$FooProps$JsMap'
  String get jsMapImplName => '$prefix$implName\$JsMap';

  /// Converts the consumer's written props classname to the consumable props
  /// classname by stripping [privateSourcePrefix] from the classname.
  ///
  /// Example:
  ///   Input: '_$FooProps'
  ///   Output: 'FooProps'
  ///   Input: '_$_FooProps'
  ///   Output: '_FooProps'
  String get publicName => '$prefix$_normalizedName';

  /// Gets the accessors mixin class from the consumer className.
  ///
  /// Example:
  ///   Input: _$FooProps
  ///   Output: _$FooPropsAccessorsMixin
  ///   Input: _$_FooProps
  ///   Output: _$_FooPropsAccessorsMixin
  String get legacyAccessorsMixinName => '$prefix${consumerName}AccessorsMixin';

  String get generatedMixinName => '$prefix\$$consumerName';

  /// Gets the meta variable name from the public pros class name.
  ///
  /// Example:
  ///   Input: FooProps
  ///   Output: _$metaForFooProps
  String get metaConstantName => '$prefix${privateSourcePrefix}metaFor$publicName';
}
