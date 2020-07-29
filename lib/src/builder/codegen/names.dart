// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import '../util.dart';

/// A set of names of the different generated members for a given factory variable.
///
/// Supports prefixed identifiers (e.g., `foo_library.Foo`).
class FactoryNames {
  final String _prefix;
  final String unprefixedConsumerName;

  factory FactoryNames(String consumerFactory) {
    final parts = consumerFactory.split('.');
    if (parts.length == 1) {
      return FactoryNames._('', consumerFactory);
    }

    return FactoryNames._('${parts[0]}.', parts.skip(1).join('.'));
  }

  FactoryNames._(this._prefix, this.unprefixedConsumerName);

  /// The name of the consumer-authored factory variable.
  ///
  /// Example: `Foo`
  String get consumerName => '$_prefix$unprefixedConsumerName';

  /// The name of the generated factory function implementation.
  ///
  /// Example:
  ///
  /// - Input: `Foo`
  /// - Output: `_$Foo`
  String get implName => '$_prefix$privateSourcePrefix${unprefixedConsumerName}';

  /// The name of the generated function component props config for the factory.
  ///
  /// Example: `$FooConfig
  String get configName => '\$${consumerName}Config';
}

/// A set of names of the different generated members for a given component class.
///
/// Supports prefixed identifiers (e.g., `foo_library.FooComponent`).
class ComponentNames {
  final String _prefix;
  final String unprefixedConsumerName;

  factory ComponentNames(String consumerComponentName) {
    final parts = consumerComponentName.split('.');
    if (parts.length == 1) {
      return ComponentNames._('', consumerComponentName);
    }

    return ComponentNames._('${parts[0]}.', parts.skip(1).join('.'));
  }

  ComponentNames._(this._prefix, this.unprefixedConsumerName);

  /// The name of the consumer-authored class.
  ///
  /// Example: `FooComponent`
  String get consumerName => '$_prefix$unprefixedConsumerName';

  /// The name of the generated component factory.
  ///
  /// Example:
  ///
  /// - Input: `FooComponent`
  /// - Output: `$FooComponentFactory`
  ///
  /// NOTE: The factory name must be public, since sub components will reference
  /// factories from super components.
  String get componentFactoryName =>
      '$_prefix$publicGeneratedPrefix${unprefixedConsumerName}Factory';

  /// The name of the generated component implementation class.
  ///
  /// Example:
  ///
  /// - Input: `FooComponent`
  /// - Output: `_$FooComponent`
  String get implName => '$_prefix$privateSourcePrefix$unprefixedConsumerName';
}

/// A set of names of the different generated members for a given typed map class
/// (either a props, state, props mixin, or state mixin class).
///
/// Supports prefixed identifiers (e.g., `foo_library.FooProps`).
class TypedMapNames {
  final String _prefix;
  final String _unprefixedConsumerName;

  TypedMapNames._(this._prefix, this._unprefixedConsumerName);

  factory TypedMapNames(String consumerName) {
    final parts = consumerName.split('.');
    if (parts.length == 1) {
      return TypedMapNames._('', consumerName);
    }

    return TypedMapNames._('${parts[0]}.', parts.skip(1).join('.'));
  }

  String get _normalizedName => _unprefixedConsumerName.replaceFirst(privateSourcePrefix, '');

  /// The name of the consumer-authored class.
  ///
  /// Example:
  ///
  /// - `_$FooProps` (legacy boilerplate)
  /// - `FooProps` (new boilerplate)
  /// - foo_library.FooProps`
  String get consumerName => '$_prefix$_unprefixedConsumerName';

  /// The name of the generated concrete props/state implementation.
  ///
  /// Example:
  ///
  /// | Version     | [consumerName] | Value        |
  /// |-------------|----------------|--------------|
  /// | Legacy      | _$FooProps     | _$$FooProps  |
  /// | Legacy      | _$_FooProps    | _$$_FooProps |
  /// | Mixin-based | FooProps       | $FooProps    |
  String get implName => '$_prefix$privateSourcePrefix\$$_normalizedName';

  /// The name of the generated concrete props/state implementation subclass
  /// that can be backed by any Map.
  ///
  /// Example:
  ///
  /// | Version     | [consumerName] | Value                 |
  /// |-------------|----------------|-----------------------|
  /// | Legacy      | _$FooProps     | _$$FooProps$PlainMap  |
  /// | Legacy      | _$_FooProps    | _$$_FooProps$PlainMap |
  /// | Mixin-based | FooProps       | $FooProps$PlainMap    |
  String get plainMapImplName => '$implName\$PlainMap';

  /// The name of the generated concrete props/state implementation subclass
  /// that can be backed only by JsBackedMaps.
  ///
  /// Example:
  ///
  /// | Version     | [consumerName] | Value              |
  /// |-------------|----------------|--------------------|
  /// | Legacy      | _$FooProps     | _$$FooProps$JsMap  |
  /// | Legacy      | _$_FooProps    | _$$_FooProps$JsMap |
  /// | Mixin-based | FooProps       | $FooProps$JsMap    |
  String get jsMapImplName => '$implName\$JsMap';

  /// The name of the consumable props/state class.
  ///
  /// - For legacy backwards compatible boilerplate, this is the companion class.
  /// - For legacy Dart-2-only boilerplate, this is the generated public class.
  /// - For new mixin-based boilerplate, this is the same as [consumerName].
  ///
  /// Example:
  ///
  /// | Version     | [consumerName] | Value    |
  /// |-------------|----------------|----------|
  /// | Legacy      | _$FooProps     | FooProps |
  /// | Mixin-based | FooProps       | FooProps |
  String get publicName => '$_prefix$_normalizedName';

  /// The name of the generated accessors mixin for a props/state class.
  ///
  /// This is only applicable for legacy boilerplate.
  ///
  /// Example:
  ///
  /// | Version | [consumerName] | Value                     |
  /// |---------|----------------|---------------------------|
  /// | Legacy  | _$FooProps     | _$FooPropsAccessorsMixin  |
  /// | Legacy  | _$_FooProps    | _$_FooPropsAccessorsMixin |
  String get legacyAccessorsMixinName => '$_prefix${_unprefixedConsumerName}AccessorsMixin';

  /// The name of the generated mixin that contains accessors for a props/state mixin.
  ///
  /// Example:
  ///
  /// | Version                   | [consumerName]  | Value          |
  /// |---------------------------|-----------------|----------------|
  /// | Legacy (backwards-compat) | FooPropsMixin   | $FooPropsMixin |
  /// | Legacy (Dart 2 only)      | _$FooPropsMixin | FooPropsMixin  |
  /// | Mixin-based               | FooPropsMixin   | $FooPropsMixin |
  String get generatedMixinName => _unprefixedConsumerName.startsWith(privateSourcePrefix)
      ? publicName
      : '$_prefix\$$_normalizedName';

  /// A prefixed identifier that references the public generated props/state meta constant.
  ///
  /// Only applicable for mixin-based boilerplate.
  ///
  /// Example:
  ///
  /// | Version     | [consumerName]  | Value               |
  /// |-------------|-----------------|---------------------|
  /// | Mixin-based | FooPropsMixin   | $FooPropsMixin.meta |
  String get publicGeneratedMetaName => '$generatedMixinName.meta';

  /// The name of the private generated meta variable.
  ///
  /// Not applicable to new boilerplate props/state classes.
  ///
  /// | Version                   | [consumerName]  | Value                  |
  /// |---------------------------|-----------------|------------------------|
  /// | Legacy (backwards-compat) | FooPropsMixin   | _$metaForFooPropsMixin |
  /// | Legacy (Dart 2 only)      | _$FooPropsMixin | _$metaForFooPropsMixin |
  /// | Mixin-based               | FooPropsMixin   | _$metaForFooPropsMixin |
  /// | Legacy                    | _$FooProps      | _$metaForFooProps      |
  String get metaConstantName => '$_prefix${privateSourcePrefix}metaFor$_normalizedName';
}
