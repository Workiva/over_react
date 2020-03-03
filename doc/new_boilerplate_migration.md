# New OverReact Boilerplate Migration Guide

* __[Background](#background)__
    * [Function Component Boilerplate](#function-component-boilerplate)
    * [Problems with Previous Boilerplate](#problems-with-previous-boilerplate)
* __[New Boilerplate Updates](#new-boilerplate-updates)__
    * [Constraints](#constraints)
    * [Updates](#updates)
        * [Remove Annotations](#remove-annotations)
        * [Ignore Ungenerated Warnings Project-Wide](#ignore-ungenerated-warnings-project-wide)
        * [Use Mixin-Based Props Declaration that Disallows Subclassing](#use-mixin-based-props-declaration-that-disallows-subclassing)
* __[Function Components](#function-components)__
    * [Constraints](#function-component-constraints)
    * [Design](#design)
* __[Upgrading](#upgrading)__

## Background

While converting the boilerplate for OverReact component declaration from Dart 1 
transformers to Dart 2 builders, we encountered several constraints that made us 
choose between dropping backwards compatibility (mainly support for props class 
inheritance), and a less-than-optimal boilerplate.

To make the Dart 2 transition as smooth as possible, we chose to keep the new 
boilerplate version as backwards-compatible as possible, while compromising the 
cleanliness of the boilerplate. In time, we found that this wasn't great from a 
user experience or from a tooling perspective.

Knowing this, we now have the opportunity to implement an improved version of 
OverReact boilerplate that fixes issues introduced in the latest version, as 
well as other miscellaneous ones.

### Function Component Boilerplate

React function components, along with [hooks], are used heavily in modern React 
component architecture, and we would like to take advantage of their benefits 
within the Workiva ecosystem. However, to be truly valuable, we need strongly 
typed prop APIs for these components, which means we must provide a way to 
declare function components using OverReact boilerplate.

### Problems with Previous Boilerplate

#### Public API and Code Generation

The current, Dart-2-only boilerplate generates public props classes:

```dart
// User-authored
@Props()
class _$FooProps extends BarProps {
  String foo;
}

// Generated in .over_react.g.dart
class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {   
  static const PropsMeta meta = ...;
  ... 
}
```

In using the build packages's `build_to: cache` to generate public APIs, command-line 
tools like `dartanalyzer` and `dartdoc` don't function properly for packages that do this. 

This pattern can also degrade the dev experience, by requiring a build before code is 
statically valid, and also requiring rebuilds in some cases to consume public API 
updates during their development (e.g., writing new component props classes).

The transitional boilerplate, currently used in almost all repos, does not have these 
issues, as it requires users to stub in these public classes:

```dart
// User-authored
@Props()
class _$FooProps extends BarProps {
  String foo;
}

// Also user-authored
class FooProps
    extends _$FooProps
    with
        // ignore: mixin_of_non_class, undefined_class
        _$FooPropsAccessorsMixin {
  // ignore: const_initialized_with_non_constant_value, undefined_class, undefined_identifier    
  static const PropsMeta meta = _$metaForPanelTitleProps;
 }
```

This is overly verbose, confusing, and error-prone. Authoring components should be 
simple and easy.

#### Inheritance

Props are declared as fields, and we generate the accessor (AKA getters/setters) 
implementations that are to be used when reading and writing props.

If the consumer authors the public-facing class, we have to do this in new 
generated subclasses to be able to override the field implementation.

```dart
// Source
class FooProps {
  int foo;
}

// Generated
mixin $FooPropsAccessors on FooProps {
  @override  int get foo => props['foo'];
  @override  set foo(int value) => props['foo'] = value;
}

// This class is actually what's used under the hood, not FooProps.
class $FooProps = FooProps with $FooPropsAccessors;
```

However, if consumers were to extend from the authored class, they wouldn't 
inherit these generated fields.

```dart
class BarProps extends FooProps {
  String bar;
}

test() {
  // references `FooProps.foo`, not the `$FooProps.foo` getter as desired.
  BarProps().foo;
}
```

## New Boilerplate Updates

### Constraints

#### Technical Constraints:

1. We cannot use resolved AST to generate components because it slows down 
the build too much.

    In other words, we have access to the structure of the code within a 
    given file but not its full semantic meaning, and cannot resolve 
    references it makes to code in other files.
    
    For instance, we can look at a class and see the name of the class it 
    extends from and the methods it declares, but we won't be able to know 
    where the parent class comes from, what type(s) the parent implements, 
    or which member(s) the parent declares.

2. User-authored code must reference generated code somehow to "wire it up".

    Since generated code can be output only to new files, component 
    registration / wiring of generated code requires either:
    
    1. a centralized, generated registry that maps components to generated 
    component code, and that must be generated for and consumed in that 
    main() method of all consuming apps' entrypoints.
    
    2. a user-authored entrypoint (field initializer, method invocation, 
    constructor, etc.) that imports (or pulls in via a part) and references 
    generated code (what we have now).

#### Self-Imposed Constraints:

1. Keep component declarations as terse and user-friendly as possible.

2. Use `build_to: cache` (for more information, see: [pkg:build docs]).
    
    `build_to:cache` should be used when generated code is dependent on the 
    library's underlying implementation. This may not be strictly the case 
    today, but if we commit to `build_to: cache`, we will have more 
    flexibility in the future to make improvements or fix bugs to OverReact 
    code generation without requiring a (very expensive) breaking change. 
    
    It would also result in improvements to the builder being propagated 
    immediately as soon as they're consumed by wdesk, as opposed to having 
    to regenerate code and release within every consumer library.

3. Make source code statically analyzable without running codegen.

    The build docs instruct not to use build_to: cache to generate public 
    APIs, and command-line tools like `dartanalyzer` and `dartdoc` don't 
    function properly for packages that do this. 
    
    Generating public APIs can also degrade the dev experience, by requiring 
    a build before code is statically valid, and also requiring rebuilds in 
    some cases to consume public API updates during their development (e.g., 
    writing new component props classes).
    
4. Provide some means of sharing props/state declarations between 
components.

    Being able to share props/state between multiple components is useful, 
    especially when composing them together. We also have many legacy 
    components that currently share props, and want to make it possible 
    to upgrade them.
    
5. Provide a simple migration path for _most_ components in the Wdesk 
ecosystem.

    We can support new/old boilerplate at the same time, and slowly phase 
    out the old as we migrate over to it using codemods.
    
    For cases that don't migrate cleanly, we can use the Wdesk versioning 
    policy to replace them with APIs that use the new boilerplate in major 
    versions or using versioned APIs. This applies to a small set of 
    components within Wdesk whose props classes are public APIs, 
    concentrated in web_skin_dart and to alesser extent graph_ui.
    
6. Only support Component2 components.

    The builder has different code paths for Component/Component2, and 
    supporting an additional boilerplate for both would increase code 
    complexity and effort needed to build/test it. 

### Updates

#### Remove Annotations

`@Factory()`, `@Props()` and `@Component()` annotations add additional 
visual clutter to the boilerplate, and are redundant since the factory/
props/component declarations already have a consistent/restricted 
structure and naming scheme that makes it clear to the builder parsing 
logic that a component is being defined, and what each part is.

```diff
- @Factory()
UiFactory<FooProps> Foo =
    // ignore: undefined_identifier
    $Foo;

- @Props()
class _$FooProps extends BarProps {
  String foo;
}

- @Component2()
class FooComponent extends UiComponent2<FooProps> {
  @override
  render() => 'foo: ${props.foo}';
}
```

Annotations could still be used, opt-in, if custom configuration is needed.

```dart
@Props(keyNamespace: 'customNamespace.')
class _$FooProps extends BarProps {
  String foo;
}
```

#### Ignore Ungenerated Warnings Project-Wide

Right now, we have to add `// ignore: uri_has_not_been_generated` to each 
component library on the part/import that references generated code.

Ignoring this hint globally within analysis_options.yaml:

```yaml
 analyzer:
   errors:
     uri_has_not_been_generated: ignore 
```

Allows individual ignores to be omitted, which will reduce clutter in 
the component boilerplate.

```diff
- // ignore: uri_has_not_been_generated
part 'foo.over_react.g.dart';
```

#### Use Mixin-Based Props Declaration that Disallows Subclassing

_Constraints_:

* Props classes must directly subclass UiProps, only inheriting other props 
via mixins.

    * This requires consumers to include every single mixin within their `with` 
    clause, allowing the builder to mix in the generated code corresponding 
    to those mixins.
    
* Generated props mixin classes (`$FooPropsMixin`) must be exported along with 
their source class `$FooProps`. These APIs are considered public, but should 
only ever be referenced from other code generated by the over_react builder.

##### New Boilerplate (from Dart 2 only boilerplate)

```diff
import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

- @Factory()
UiFactory<FooProps> Foo =
    // ignore: undefined_identifier
    $Foo;

- @Props()
- class _$FooProps extends BarProps {
+ mixin FooPropsMixin on UiProps {
  String foo;
}

+ class FooProps = UiProps with FooPropsMixin, BarPropsMixin;

- @Component2()
class FooComponent extends UiComponent2<FooProps> {
  @override
  render() => 'foo: ${props.foo}';
}
```

_Generated code_:

```dart
part of 'foo.dart';

//
// (Component and factory code is pretty much the same.)
//

mixin $FooPropsMixin on FooPropsMixin {
  @override
  String get foo => props['foo'];
  @override
  set foo(String value) => props['foo'] = value;
}

class _$FooPropsImpl extends FooProps
    // These mixins are derived from the list of mixins in the source
    with $FooPropsMixin, $BarPropsMixin {}
```

##### Abbreviated Version

When no other mixins are used, skip the props class and just use the mixin.

```dart
import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = $Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {
  String foo;
}

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() => 'foo: ${props.foo}';
}
```

##### Props Meta Changes

Props meta will be generated as an overridden getter on the component 
as opposed to the current static field, and will allow similar access 
of prop keys as before.

This eliminates the current `meta` portion of the boilerplate which has 
to reference more generated code.

Prop meta from all mixins can be accessed, allowing us to default 
consumedProps to all props statically accessible from that component.

Consumption: 

```dart
@Props()
class FooProps extends UiProps with FooPropsMixin, BarPropsMixin {}

@PropsMixin()
mixin FooPropsMixin on UiProps {
  @requiredProp
  int foo;
}

@Component2()
class FooComponent extends UiComponent2<FooProps> {
  @override
  render() => [props.foo];

  @override
  get consumedProps => [
    propsMeta.forMixin(FooPropsMixin),
  ];

  test() {
    print(propsMeta.keys); // ('foo', 'bar')
    print(propsMeta.forMixin(FooPropsMixin).keys); // ('foo')
    print(propsMeta.forMixin(BarPropsMixin).keys); // ('bar')
  }
}

// Generated code
class _FooCopmonentImpl extends FooComponent {
  // ...

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
    FooPropsMixin: $FooPropsMixin.meta,
    BarPropsMixin: $BarPropsMixin.meta,
  });
}
```

Over_react updates:

```dart
// A new field in component base class
class UiComponent2 ... {
  /// A collection of metadata for the prop fields in all prop mixins
  /// used by the props class of this component.
  PropsMetaCollection get propsMeta => null;
}
```

A new class in over_react:

```dart
/// A collection of metadata for the prop fields in all prop mixins
/// used by a given component.
///
/// See [PropsMeta] for more info.
class PropsMetaCollection implements PropsMeta {
  final Map<Type, PropsMeta> _metaByMixin;

  const PropsMetaCollection(this._metaByMixin);

  /// Returns the metadata for only the prop fields declared in [mixinType].
  PropsMeta forMixin(Type mixinType) {
    final meta = _metaByMixin[mixinType];
    assert(meta != null, 
        'No meta found for $mixinType;'
        'it likely isn\'t mixed in by the props class.')
    return meta ?? const PropsMeta(fields: [], keys: []);
  }

  // PropsMeta overrides

  @override
  List<String> get keys => 
        _metaByMixin.values.expand((meta) => meta.keys).toList();

  @override
  List<PropDescriptor> get fields => 
        _metaByMixin.values.expand((meta) => meta.fields).toList();

  @override
  List<PropDescriptor> get props => fields;
}
```

##### Props MapViews

Since props mixins can only be consumed by other generated code, the 
existing props map view consumption pattern, whereby props mixins are 
consumed in user-authored MapView subclasses, cannot be supported.

Instead, props map views will be declared similarly to a component, 
with a factory and props mixin/class, but no component. 

```diff
import 'package:over_react/over_react.dart';

+ part 'foo.over_react.g.dart';

- class FooPropsMapView extends UiPropsMapView with SomeOtherPropsMixin {
-   FooPropsMapView(Map backingMap) : super(backingMap);
- }

+ UiFactory<FooMapViewProps> FooMapView = $FooMapView; // ignore: undefined_identifier

+ class FooMapViewProps = UiProps with SomeOtherPropsMixin;

usage() {
-   final mapView = FooPropsMapView(someExistingMap);
+   final mapView = FooMapView(someExistingMap);
}
```

## Function Components

### Function Component Constraints 

Includes all of [the constraints listed in the Boilerplate Updates section](#constraints), 
ignoring parts about backwards-compatibility.

* Should be as visually uncluttered as possible.

* Should not wrap excessively for longer component names.

* Should be easy to transition between having and not having default 
props, and boilerplate shouldn't change shape drastically when doing so.

* Function calls using generated functions should be avoided since they 
don't allow generic type inference of the `props` arg in the function 
closure.

### Design

```dart
import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = uiFunctionComponent(
  (props) {
    return 'foo: ${props.foo}'; 
  },
  $fooPropsConfig, // ignore: undefined_identifier
); 

mixin FooProps on UiProps {
  String foo;
}
```

Here, `uiFunctionComponent` gets a generic parameter of `FooProps` inferred 
from the LHS typing, allowing props to be statically typed as `FooProps`.

The generated `$FooPropsConfig` is passed in as an argument, and serves 
as the entrypoint to the generated code. 

#### With Default Props

`defaultProps` on function components is [already deprecated](https://github.com/facebook/react/pull/16210).

Use null-aware operators to default null values. This provides almost the
same behavior as `defaultProps`, but with the restriction that a given prop
__must either be nullable or have a default value, but not both__.

```dart
UiFactory<FooProps> Foo = uiFunctionComponent(
  (props) {
    final foo = props.foo ?? 'default foo value';

    return 'foo: $foo'; 
  },
  $fooPropsConfig, // ignore: undefined_identifier
); 
```

#### With propTypes

```dart
UiFactory<FooProps> Foo = uiFunctionComponent(
  (props) {
    return 'foo: ${props.foo}'; 
  }, 
  $fooPropsConfig, // ignore: undefined_identifier
  getPropTypes: (keyFor) => {
    keyFor((p) => p.foo): (props, info) {
      if (props.foo == 'bar') {
        return PropError('You can\'t foo a bar, silly');
      }
    }
  },
);
```

`getPropTypes` provides a way to set up prop validation within the 
same variable initializer.

#### Local function components using just a props mixin (no top-level Factory necessary)

```dart
import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

mixin FooProps on UiProps {
  String foo;
}

// Example function; this can look like anything and doesn't have to 
// be declared in this file. 
UiFactory<FooProps> createFooHoc(UiFactory otherFactory) { 
  Object closureVariable; 
  // ... 

  final FooHoc = uiFunctionComponent<FooProps>(
    (props) { 
      return otherFactory()( 
        Dom.div()('closureVariable: ${closureVariable}'), 
        Dom.div()('prop foo: ${props.foo}'), 
      );   
    },
    $fooPropsConfig, // ignore: undefined_identifier 
  ); 

  return FooHoc; 
} 
```

## Upgrading

To update your repository to the new boilerplate, you can use 
[over_react_codemod]'s `boilerplate_upgrade` executable to make it 
easier. This codemod goes through the repository and updates the 
boilerplate as necessary. While the codemod will handle many basic 
updates, it will still need to be supplemented with some manual 
checks and refactoring. 

Before running the codemod, run `semver_audit` inside your repository 
and save the report using the following commands:

1. `pub global activate semver_audit --hosted-url=https://pub.workiva.org`
2. `pub global run semver_audit generate 2> semver_report.json`

This will allow the codemod to check whether or not components are
public API.

Then, run the codemod by following the directions within 
[the executable](https://github.com/Workiva/over_react_codemod/blob/master/lib/src/executables/boilerplate_upgrade.dart#L32)
while inside your repository.

#### Flags

When running the command `pub global run over_react_codemod:boilerplate_upgrade` 
to update your components, there are two flags that can be used:

* `--treat-all-components-as-private`: assumes that all components are not
publicly exported and thus can be upgraded to the new boilerplate. Without
this flag, all components that are publicly exported (as determined by the
semver report) _will not_ be upgraded.

* `--convert-classes-with-external-superclasses`: allows classes with external
superclasses to be upgraded to the new boilerplate. Without this flag, all classes
with external superclasses _will not_ be upgraded.

[angular-dart]: https://github.com/dart-lang/angular/blob/d2e4c599ab5a3ee0544d8c639a4de4e011b14517/doc/migrating-to-v5.md#adjust-analysis_optionsyaml
[hooks]: https://reactjs.org/docs/hooks-intro.html
[over_react_codemod]: https://github.com/Workiva/over_react_codemod
[pkg:build docs]: https://github.com/dart-lang/build/blob/master/docs/builder_author_faq.md#when-should-a-builder-build-to-cache-vs-source
