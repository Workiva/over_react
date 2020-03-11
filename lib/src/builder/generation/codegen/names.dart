import 'package:meta/meta.dart';

import '../../util.dart';

class ComponentNames {
  final String componentName;

  ComponentNames(this.componentName);

  /// Gets the generated component factory name from the component classname.
  ///
  /// Example:
  ///   Input: FooComponent
  ///   Output: $FooComponentFactory
  ///
  /// NOTE: The factory name must be public, since sub components will reference
  /// factories from super components.
  String get componentFactoryName =>  '$publicGeneratedPrefix${componentName}Factory';

  String get implName => '$privateSourcePrefix$componentName';
}

class AccessorNames {
  final String consumerName;

  String get unprefixedName => consumerName.replaceFirst(privateSourcePrefix, '');

  AccessorNames({@required this.consumerName});

  /// Converts the consumer's written props classname to the concrete props
  /// implementation's classname by adding '$' to the [privateSourcePrefix].
  ///
  /// Example:
  ///   Input: '_$FooProps'
  ///   Output: '_$$FooProps'
  ///   Input: '_$_FooProps'
  ///   Output: '_$$_FooProps'
  String get implName => '$privateSourcePrefix\$$unprefixedName';

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
  String get publicName => unprefixedName;

  /// Gets the accessors mixin class from the consumer className.
  ///
  /// Example:
  ///   Input: _$FooProps
  ///   Output: _$FooPropsAccessorsMixin
  ///   Input: _$_FooProps
  ///   Output: _$_FooPropsAccessorsMixin
  String get legacyAccessorsMixinName => '${consumerName}AccessorsMixin';

  String get generatedMixinName => '\$$consumerName';

  /// Gets the meta variable name from the public pros class name.
  ///
  /// Example:
  ///   Input: FooProps
  ///   Output: _$metaForFooProps
  String get metaConstantName => '${privateSourcePrefix}metaFor$publicName';
}
