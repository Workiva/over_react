# OverReact Changelog

## [3.2.0](https://github.com/Workiva/over_react/compare/3.1.7...3.2.0)

- [#439] Add `over_react_redux` example app
- [#447] Add `StrictMode` component
- [#452] Add `built_redux` to Redux transition Docs
- [#453] Fix rem measurement bug

## [3.1.7](https://github.com/Workiva/over_react/compare/3.1.6...3.1.7)

- [#435] Fix issue with `ErrorBoundary` that causes errors thrown within the `render` phase of the component lifecycle to bubble up to parent `ErrorBoundary` components, which resulted in entire consumer applications locking up / crashing / unmounting.
  - __DEPRECATIONS:__ `ErrorBoundaryMixin`, `ErrorBoundaryPropsMixin` and `ErrorBoundaryStateMixin` are deprecated and will be removed in the 4.0.0 release.
    - To create a custom error boundary moving forward, create an HOC that wraps around the `ErrorBoundary` component instead.
- [#433] Refactor `propTypes` tests
- [#440] Make over_react_redux tests compatible with version `^7.1.1` of the redux JS library
- [#442] Remove Dart 2.4.1 phase from the CI build
- [#428] Add examples of components that have `render` methods that return  `Fragment`, `List`, `num` and `String`

## [3.1.6](https://github.com/Workiva/over_react/compare/3.1.5...3.1.6)
- Remove dead code in `UiProps.build` that was unnecessarily slowing down dart2js compilation
- Fix README typos

## [3.1.5](https://github.com/Workiva/over_react/compare/3.1.4...3.1.5)

- Fix `ErrorBoundary` infinite loop when multiple errors are thrown at the same time during remount
- Fix `connect`'s `mapStateToOwnPropsWithProps` not getting called

## [3.1.4](https://github.com/Workiva/over_react/compare/3.1.3...3.1.4)

- Replace usage / mention of `UiComponent2.getPropKey` which had to be deprecated in [the 3.1.2 release](https://github.com/Workiva/over_react/pull/418).
- Add a stub for `UiComponent2.redraw` with a deprecated annotation so that consumers would correctly see it as being deprecated.
  - Previously, this method would not show up as deprecated because certain IDEs would default to the base implementation (`Component.redraw`) - instead of the newer, deprecated `Component2.redraw`.

## [3.1.3](https://github.com/Workiva/over_react/compare/3.1.2...3.1.3)

- Fixes an issue that prevents `UiComponent` instances from being declared as sub-types of `UiComponent2` instances
  via the `subtypeOf` argument in a `Component2()` annotation.

## [3.1.2](https://github.com/Workiva/over_react/compare/3.1.1...3.1.2)

- Restore the public `getPropKey` function that was accidentally made private in the 3.1.0 release.

## [3.1.1](https://github.com/Workiva/over_react/compare/3.1.0...3.1.1)

- Restore the `xmlLang`, `xmlSpace`, `y1`, `y2`, `y` members that were accidentally removed from `SvgProps` in the 3.1.0 release.

## [3.1.0](https://github.com/Workiva/over_react/compare/3.0.0+dart2...3.1.0)

### Full React JS 16.x Component Lifecycle Support

- The new `UiComponent2` classes<sup>＊</sup> replace the now deprecated `UiComponent` classes.

  <sup>＊</sup>_(`UiComponent2`, `UiStatefulComponent2`, `FluxUiComponent2`)_
  - Faster
    - Initial renders ~10% faster
    - Re-renders ~7 - 30% faster
  - Improved developer experience
     - Props and state values now show up in the React DevTools just as they would if you were using React JS, and primitive values (strings, numbers, booleans) can be edited live, just like in React JS!

        ![React DevTools with Component2](https://user-images.githubusercontent.com/1750797/68478015-1259b500-01ec-11ea-92bf-0bd432cd4001.gif)
  - Easier to maintain
  - Easier integration with JS libs
    - `ReactJsComponentFactoryProxy` makes it easy to use JS components with Dart!
      - [Check out this example of MaterialUI components!](https://github.com/cleandart/react-dart/blob/5.1.0-wip/example/js_components/js_components.dart#L115-L145)
  - Supports new lifecycle methods, allowing us to use Concurrent Mode in the future
    - <s>`componentWillMount`</s> => `componentDidMount`
    - <s>`componentWillReceiveProps`</s> => `getDerivedStateFromProps` _(new)_
    - <s>`componentWillUpdate`</s> => `getSnapshotBeforeUpdate` _(new)_
    - `componentDidCatch` / `getDerivedStateFromError` _(new)_
      - Adds support for [error boundaries](https://reactjs.org/docs/error-boundaries.html).
      - OverReact also provides an `ErrorBoundary` component out of the box that you can wrap around your components, and an `ErrorBoundaryMixin` that you can use as a starting point to build your own custom error boundary component!

> [__Learn more about upgrading to `UiComponent2`__](https://github.com/Workiva/over_react/blob/master/doc/ui_component2_transition.md#updating)

### Improved, stable [Context](https://reactjs.org/docs/context.html) API

- _"Context provides a way to pass data through the component tree without having to pass props down manually at every level. … Context is primarily used when some data needs to be accessible by many components at different nesting levels. Apply it sparingly because it makes component reuse more difficult."_

### New `over_react_redux.dart` Library

- To take full advantage of the new stable `Context` API, we have built atop
  the awesome [redux.dart library](https://github.com/johnpryan/redux.dart) to make it easy
  to set up redux provider(s) / consumer(s) for OverReact components that enable granular, targeted updates!
    - Check out [some examples](https://github.com/Workiva/over_react/tree/master/web/over_react_redux)
      by cloning this project locally, running `webdev serve` from the root of the project, and navigating to <http://localhost:8080/over_react_redux/>.
    - Use it in your project by [upgrading your `UiComponent`s to `UiComponent2`](https://github.com/Workiva/over_react/blob/master/doc/ui_component2_transition.md#updating) and importing `package:over_react/over_react_redux.dart`!
- We've even got some sweet [redux dev tools you can use](https://github.com/Workiva/over_react/blob/master/doc/over_react_redux_documentation.md#using-redux-devtools) to make the inspection of connected state a breeze!
  ![over_react_redux.dart developer tools](http://g.recordit.co/NLeAZQkCFm.gif)

> [__Learn more about using over_react_redux.dart__](https://github.com/Workiva/over_react/blob/master/doc/over_react_redux_documentation.md)

### [Portals](https://reactjs.org/docs/portals.html)

- _"Portals provide a first-class way to render children into a DOM node that exists outside the DOM hierarchy of the parent component."_

### [Fragments](https://reactjs.org/docs/fragments.html)

- _"A common pattern in React is for a component to return multiple elements. Fragments let you group a list of children without adding extra nodes to the DOM."_
- `UiComponent.render()` can now return a `ReactFragment` (multiple children) or other values like strings and lists instead of just a single `ReactElement`.

### No more Dart 1 SDK support

- With the release of `3.1.0` comes the end of our `+dart1` / `+dart2` dual releases that we have been
  maintaining for over a year.  Time to upgrade to Dart 2!

> [Full list of 3.1.0 Changes](https://github.com/Workiva/over_react/milestone/3?closed=1)

## 3.0.2

Dependency updates:
- Lower the dart_style constraint from ^1.3.1 to ^1.2.5 to help avoid version lock in downstream packages
- Open up built_value range to include 8.0.0

> Complete `3.0.2` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/3.0.1+dart2...3.0.2+dart2)
> - Dart 1 (No Changes)

## 3.0.1

- Lower the Dart SDK lower-bound to `2.4.0`. It was accidentally raised to `2.4.1` in the 3.0.0 release.

> Complete `3.0.1` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/3.0.0+dart2...3.0.1+dart2)
> - Dart 1 (No Changes)

## 3.0.0

__ReactJS 16.x Support__

- Support for the new / updated lifecycle methods from ReactJS 16 [will be released in version `3.1.0`](https://github.com/Workiva/over_react/milestone/3).

> Complete `3.0.0` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.7.0+dart2...3.0.0+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.7.0+dart1...3.0.0+dart1)

> __[Full List of Breaking Changes](https://github.com/Workiva/over_react/pull/408)__

## 2.7.0

> Complete `2.7.0` Changsets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.6.1+dart2...2.7.0+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.6.1+dart1...2.7.0+dart1)

* This release brings in the `SafeRenderManager` utilities added to the 3.x alpha line-of-release via [#390]

## 2.7.0

> Complete `2.7.0` Changsets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.6.1+dart2...2.7.0+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.6.1+dart1...2.7.0+dart1)

* This release brings in the `SafeRenderManager` utilities added to the 3.x alpha line-of-release via [#390]

## 2.6.1

> Complete `2.6.1` Changsets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.6.0+dart2...2.6.1+dart2)
> - Dart 1 (No Changes)

* [#382] Update prop typedef to work around [Dart 2.6 compiler regression](https://github.com/dart-lang/sdk/issues/38880)

## 2.6.0

> Complete `2.6.0` Changsets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.5.3+dart2...2.6.0+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.5.3+dart1...2.6.0+dart1)

* Adds a placeholder prop API to mirror the 3.x ErrorBoundary APIs ([#370]) added to configure logging.
  The API is not wired up in 2.x, but will make the transition for consumers to 3.x smoother.

## 2.5.3

> Complete `2.5.3` Changsets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.5.2+dart2...2.5.3+dart2)
> - Dart 1 (no changes)

* [#363] Dart 2 Widen `analyzer` dependency range

## 2.5.2

> Complete `2.5.2` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.5.1+dart2...2.5.2+dart2)
> - Dart 1 (no changes)

* [#333] Expand upper-bound of `quiver` dependency to `<3.0.0`

## 2.5.1

> Complete `2.5.1` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.5.0+dart2...2.5.1+dart2)
> - Dart 1 (no changes)

* Increase Dart SDK dependency lower-bound to `2.4.0`

## 2.5.0

> Complete `2.5.0` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.4.4+dart2...2.5.0+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.4.2+dart1...2.5.0+dart1)

* [#327] Add support for `SyntheticAnimationEvent` / `SyntheticTransitionEvent`

## 2.4.4

> Complete `2.4.4` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.4.3+dart2...2.4.4+dart2)
> - Dart 1 (no changes)

* [#310] Upgrade to dart 2.4, analyzer 0.36.x, and build_web_compilers 2.x

## 2.4.3

> Complete `2.4.3` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.4.2+dart2...2.4.3+dart2)
> - Dart 1 (no changes)

* [#302] The builder now warns if an `.over_react.g.dart` part directive is found
  in a file that does not need one (i.e. it does not produce any generated output).
* [#306] The handler chaining utils (e.g. `domEventCallbacks`, `Callback1Arg`, etc.)
  have been updated to accommodate the breaking language change in Dart 2.4
  around covariance of type variables used in super-interfaces.

## 2.4.2

> Complete `2.4.2` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.4.1+dart2...2.4.2+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.4.1+dart1...2.4.2+dart1)

* [#288] Downgrade parse error to fine so as to not fail build unnecessarily.
* [#292] Update `react` dependency to version `^4.7.0`, and remove references to deprecated `jsify`, `getProperty` and `setProperty` members.
* [#294] Fix issue with `AbstractTransitionComponent` that causes ReactJS `setState` warnings to appear in the browser console.

## 2.4.1

> Complete `2.4.1` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.4.0+dart2...2.4.1+dart2)
> - Dart 1 (no changes)

* [#281] Upgrade to `analyzer ^0.35.0`.

## 2.4.0

> Complete `2.4.0` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.3.1+dart2...2.4.0+dart2)
> - Dart 1 (no changes)

* [#280] Optimize the over_react builder to avoid unnecessary asset reads.
  Informal profiling in a large codebase that consumes over_react has shown in
  the best case a speed up on rebuilds from ~1 minute to ~2 seconds, and in the
  worst case no difference at all.

## 2.3.1

> Complete `2.3.1` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.3.0+dart2...2.3.1+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.3.0+dart1...2.3.1+dart1)

* [#272] Add `min-height: 0` to `ResizeSensor` wrapper nodes to fix issues with it not shrinking in a flexbox layout

## 2.3.0

> Complete `2.3.0` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.2.0+dart2...2.3.0+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.2.0+dart1...2.3.0+dart1)

* [#266] Add `ErrorBoundary` Component
  > This component does not actually hook into any ReactJS 16 lifecycle yet. It won't until support for ReactJS 16 is added to react-dart in version 5.0.0, and to over_react in version 3.0.0.

## 2.2.0

> Complete `2.2.0` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.1.0+dart2...2.2.0+dart2)
> - [Dart 1](https://github.com/Workiva/over_react/compare/2.1.0+dart1...2.2.0+dart1)

- [#249] Warn consumers about props / state mutation
  - Directly mutating props and state is an antipattern and can cause unpredictable rendering.
      Avoiding this will be especially important for components to behave correctly in React 16's [concurrent mode](https://reactjs.org/blog/2018/11/27/react-16-roadmap.html#react-16x-q2-2019-the-one-with-concurrent-mode).

- [#255] Update for future compatibility with `react` 5.0.0

## 2.1.0

> Complete `2.1.0` Changesets:
>
> - [Dart 2](https://github.com/Workiva/over_react/compare/2.0.0+dart2...2.1.0+dart2)
> - Dart 1 (no changes)

- [#249] Warn consumers about props / state mutation
  - Directly mutating props and state is an antipattern and can cause unpredictable rendering.
      Avoiding this will be especially important for components to behave correctly in React 16's [concurrent mode](https://reactjs.org/blog/2018/11/27/react-16-roadmap.html#react-16x-q2-2019-the-one-with-concurrent-mode).

- [#254] Add IDE snippets (WebStorm/IntelliJ and VSCode) for Dart2-only
  component boilerplate.

- [#253] Fix a bug that would cause a runtime exception for consumers that are
  leveraging the backwards-compatible component boilerplate when mixing in a
  `@PropsMixin` or `@StateMixin` from this package.

- [#256] Workaround a Dart Dev Compiler bug that affects private props/state
  members and classes.

- [#252] Workaround the following Dart Dev Compiler bug that results in
  incorrect behavior in certain scenarios when using uninitialized props/state
  fields: [dart-lang/sdk#36052](https://github.com/dart-lang/sdk/issues/36052)

- [#251] Update the builder's `auto_apply` option to `dependents` instead of
  `all_packages`. This means it will only run on packages that explicitly
  declare a dependency on `over_react`, which makes more sense for the purpose
  of this builder _and_ is more performant because it runs on fewer packages.

- [#250] Fail CI if changes are detected after running a build via
  `pub run build_runner build`. This ensures that we don't forget to commit
  changes to generated files.

## 2.0.0

> [Complete `2.0.0` Changeset](https://github.com/Workiva/over_react/compare/1.31.0...2.0.0)

This release adds support for Dart 2 while retaining backwards-compatibility
with Dart 1, **but it requires changes to consumer's component code.**

> Note: If you intend to consume this version of over_react on Dart 1 and Dart 2
> in the same codebase, **do not** remove the `transformers` section from your
> `pubspec.yaml`. This section is ignored on Dart 2, but will still be needed on Dart 1

__Breaking Changes__

* In order to add support for Dart 2, consumers need to update their over_react
    component code! Please see our [Dart 2 migration guide](https://github.com/Workiva/over_react/blob/master/doc/dart2_migration.md)
    for more information.

    We've created a codemod tool that will automatically update your code:

    ```bash
    # On Dart 2.1.0
    $ pub global activate over_react_codemod ^1.0.2

    # If you need backwards-compatibility with Dart 1:
    $ pub global run over_react_codemod:dart2_upgrade --backwards-compat

    # Or, if you are okay with dropping Dart 1 support:
    $ pub global run over_react_codemod:dart2_upgrade
    ```

    The tool (and additional info) can be found here: https://github.com/Workiva/over_react_codemod/

* Removals:
  * `getJsProps()` - use `getProps()` instead
  * `$Props` and `$PropKeys` - see the migration guide above

## 1.33.2

* [#292] Update `react` dependency to version `^4.7.0`, and remove references to deprecated `jsify`, `getProperty` and `setProperty` members.
* [#294] Fix issue with `AbstractTransitionComponent` that causes ReactJS `setState` warnings to appear in the browser console.



## 1.33.1

* [#272] Add `min-height: 0` to `ResizeSensor` wrapper nodes to fix issues with it not shrinking in a flexbox layout

## 1.33.0

> [Complete `1.33.0` Changeset](https://github.com/Workiva/over_react/compare/1.32.0...1.33.0)

* [#266] Add `ErrorBoundary` Component
  > This component does not actually hook into any ReactJS 16 lifecycle yet. It won't until support for ReactJS 16 is added to react-dart in version 5.0.0, and to over_react in version 3.0.0.

## 1.32.0

> [Complete `1.32.0` Changeset](https://github.com/Workiva/over_react/compare/1.31.0...1.32.0)

* [#249] Warn consumers about props / state mutation
  * Directly mutating props and state is an antipattern and can cause unpredictable rendering.
      Avoiding this will be especially important for components to behave correctly in React 16's [concurrent mode](https://reactjs.org/blog/2018/11/27/react-16-roadmap.html#react-16x-q2-2019-the-one-with-concurrent-mode).

## 1.31.0

> [Complete `1.31.0` Changeset](https://github.com/Workiva/over_react/compare/1.30.2...1.31.0)

__Deprecations__

* [#230] Deprecate the following APIs (they will be removed in 2.0.0):
  * `getJsProps()` - use `getProps()` instead.
  * `$Props` and `$PropKeys` - see the [Dart 2 migration guide](https://github.com/Workiva/over_react/blob/master/doc/dart2_migration.md)
    for more information.

* [#207] Override `call()` instead of `noSuchMethod()` in the `UiProps` class.
    This was a requirement for Dart 2 compatibility, but also serves as an
    improvement - by no longer overriding `noSuchMethod()`, we will no longer be
    obscuring certain analyzer errors that should be seen by consumers.

## 1.30.2

> [Complete `1.30.2` Changeset](https://github.com/Workiva/over_react/compare/1.30.1...1.30.2)

__Bug Fixes__

* [#222] Fix the initializer validation for component factories and the static
  `meta` field on props and state classes.

## 1.30.1

> [Complete `1.30.1` Changeset](https://github.com/Workiva/over_react/compare/1.30.0...1.30.1)

__Bug Fixes__

* [#220] Fix an issue for Dart 2 compatibility with how the transformer handles
  props and state mixins that have generic type parameters.

__Tech-Debt__

* [#219] Remove `dart:mirrors` usages from tests (necessary for Dart 2
  compatibility).

__Documentation__

* [#210] Add a [Dart 2 migration guide](https://github.com/Workiva/over_react/blob/master/doc/dart2_migration.md).
* [#209] Add [Dart 1 / 2 code snippets for VSCode and WebStorm/IntelliJ](https://github.com/Workiva/over_react/blob/master/snippets/README.md).

## 1.30.0

> [Complete `1.30.0` Changeset](https://github.com/Workiva/over_react/compare/1.29.0...1.30.0)

__New Features__

* [#196] Add `componentDefaultProps` getter to `UiProps` for retrieving the
  immutable map view of a component's default props. This is an alternative to
  constructing a `UiComponent` directly and calling `getDefaultProps()`, which
  will no longer work in Dart 2.

* [#208] Add `typedDefaultPropsFor(factory)` utility function to easily obtain
  a typed view of the immutable default props for any `UiFactory`. This is
  effectively a strongly-typed version of the above `componentDefaultProps`
  getter.

__Improvements__

* [#200] [#201] [#205] [#208] Update the transformer to support new `over_react`
  component boilerplate that is compatible with both Dart 1 and Dart 2. This is
  the first step towards Dart 2 compatibility. For more information, see [#210].

## 1.29.0

> [Complete `1.29.0` Changeset](https://github.com/Workiva/over_react/compare/1.28.0...1.29.0)

__Bug fixes__

* [#197] Mount the rem-change-detecting node for a `ResizeSensor` asynchronously to prevent react from getting into a bad state

__New Features__

* [#195]: Add hooks for Flux component redraws that occur in response to store updates: `listenToStoreForRedraw`/`handleRedrawOn`
    * Implements the stuff that was missed in [#193]


## 1.28.0

> [Complete `1.28.0` Changeset](https://github.com/Workiva/over_react/compare/1.27.0...1.28.0)

__Bug fixes__

* [#193] Fix missing super calls in Flux component lifecycle methods that prevented disposal and prop validation

__New Features__

* [#193]: ~~Add hooks for Flux component redraws that occur in response to store updates: `listenToStoreForRedraw`/`handleRedrawOn`~~
    * _Actually implemented via [#195] in `1.29.0`_

__Improvements__

* [#192]: Make return type of `getDartComponent` generic
* [#190]: Merge `style` prop into styles applied to the top-level ResizeSensor node


## 1.27.0

> [Complete `1.27.0` Changeset](https://github.com/Workiva/over_react/compare/1.26.2...1.27.0)

__New Features__

* [#187]: New `ResizSensorProps.onDetachedMountCheck` prop callback and `ResizeSensorComponent.forceResetDetachedSensor` method

__Improvements__

* [#188]: Use `isNotEmpty` instead of `length == 0` check
    * _Thanks @teresy!!!_


## 1.26.2

__Bug fixes__

* [5fb73f](https://github.com/Workiva/over_react/commit/5fb73f26f92182ebd5c45c2ad5bb015a662bc3b4) Make rem change sensor container is `overflow:hidden` so it doesn't interfere with the page layout

## 1.26.1

__Dependency Updates__

* [e8fc86](https://github.com/Workiva/over_react/commit/e8fc86c9748c4cfb8af7bde91b0959827a5a7a63) Loosen lower bound of `built_value`
    * built_value `>=4.6.1 <5.2.0` (was `>=5.1.3 <5.2.0`)

## 1.26.0

> [Complete `1.26.0` Changeset](https://github.com/Workiva/over_react/compare/1.25.0...1.26.0)

__New Features__

* [#178]: Automatic document root font-size change detection in Google Chrome to overcome https://bugs.chromium.org/p/chromium/issues/detail?id=429140

__Dependency Updates__

* [881c0c](https://github.com/Workiva/over_react/commit/881c0ca0806d265ad7baf1f45aace632561ab05c) Tighten version constraints to speed up pub get
    * analyzer `>=0.30.0+4 <=0.31.0` (was `>=0.30.0 <=0.31.0`)
    * built_redux `^7.4.2` (was `^7.4.1`)
    * built_value `>=5.1.3 <5.2.0` (was `>=4.2.0 <5.2.0`)
    * js `^0.6.1+1` (was `^0.6.0`)
    * logging `>=0.11.3+2 <1.0.0` (was `>=0.11.3+1 <1.0.0`)
    * meta `^1.1.6` (was `^1.0.4`)
    * path `^1.5.1` (was `^1.4.1`)
    * react `^4.4.2` (was `^4.4.1`)
    * source_span `^1.4.1` (was `^1.4.0`)
    * transformer_utils `^0.1.5` (was `^0.1.1`)
    * w_common `^1.13.0` (was `^1.10.0`)
    * w_flux `^2.9.5` (was `^2.7.1`)
    * platform_detect `^1.3.4` (was `^1.3.2`)
    * quiver `>=0.25.0 <=0.28.0` (was `>=0.21.4 <=0.28.0`)

__Tech Debt__

* [#179]: Update CI build


## 1.25.0

> [Complete `1.25.0` Changeset](https://github.com/Workiva/over_react/compare/1.24.1...1.25.0)

__New Features__

* [#167]: New `ClassNameBuilder.merge` method and `ClassNameBuilder.merged` constructor.
* [#168]: Expose `react_wrappers` library that was previously only available via a `src/` import.


## 1.24.0

> [Complete `1.24.0` Changeset](https://github.com/Workiva/over_react/compare/1.23.1...1.24.0)

__Dependency Updates__

* [#153] react `^4.3.0` (was `^3.7.0`)
* [#151]
    * built_redux `^7.4.1` (was `>=6.1.0 <8.0.0`)
    * built_value `>=4.2.0 <5.2.0` (was `>=4.2.0 <6.0.0`)

__New Features__

* [#154]: Expose `react_dom.render`/`react_dom.unmountComponentAtNode` from the react library

__Tech Debt__

* [#151] Prepare for Dart 2 SDK
    * Address Dart 2.x SDK lints / warnings that do not constitute breaking changes
    * Address `DisposableManagerV6` deprecation
    * `UiProps` and `UiState` now extend from `MapBase`


## 1.24.1

> [Complete `1.24.1` Changeset](https://github.com/Workiva/over_react/compare/1.24.0...1.24.1)

__Dependency Updates__

* w_common `^1.10.0` (was `^1.8.0`)
* react `^4.4.1` (was `^4.3.0`)

__Tech Debt__

* Address `ReactComponentFactory` deprecation
* Address `findRenderedComponentWithType` deprecation

## 1.24.0

> [Complete `1.24.0` Changeset](https://github.com/Workiva/over_react/compare/1.23.1...1.24.0)

__Dependency Updates__

* [#153] react `^4.3.0` (was `^3.7.0`)
* [#151]
    * built_redux `^7.4.1` (was `>=6.1.0 <8.0.0`)
    * built_value `>=4.2.0 <5.2.0` (was `>=4.2.0 <6.0.0`)

__New Features__

* [#154]: Expose `react_dom.render`/`react_dom.unmountComponentAtNode` from the react library

__Tech Debt__

* [#151] Prepare for Dart 2 SDK
    * Address Dart 2.x SDK lints / warnings that do not constitute breaking changes
    * Address `DisposableManagerV6` deprecation
    * `UiProps` and `UiState` now extend from `MapBase`


## 1.23.1

> [Complete `1.23.1` Changeset](https://github.com/Workiva/over_react/compare/1.23.0...1.23.1)

__Dependency Updates__
* [#149]: Dependency Maintenance:
    * __Dart SDK__ now `>=1.24.2 <2.0.0`, was `>=1.24.2`
    * Dependencies:
        * __analyzer__ now `>=0.30.0 <=0.31.0`, was `>=0.30.0 <0.31.0`
        * __barback__ now `>=0.15.2 <=0.15.2+14`, was `^0.15.0`
        * __quiver__ now `>=0.21.4 <=0.28.0`, was `>=0.21.4 <0.26.0`
    * Dev Dependencies:
        * __coverage__ now `>=0.7.2 <0.11.0`, was `^0.7.2`
        * __dependency_validator__ now `^1.1.0`, was `^1.0.0`
        * __mockito__ now `^2.0.0`, was `^0.11.0`
        * __test__ now `^0.12.32+1`, was `^0.12.24`

## 1.23.0

> [Complete `1.23.0` Changeset](https://github.com/Workiva/over_react/compare/1.22.0...1.23.0)

__Dependency Updates__
* [#145]: Widen built_value version constraint: now `>=4.2.0 <6.0.0`, was `^4.2.0`

__New Features__
* [#144]: Move `BuiltReduxUiComponent`/`BuiltReduxUiProps` out of @experimental
    * __Warning:__ This will be deprecated in an upcoming release in favor of a different approach to creating a `built_redux` component.

## 1.22.0

> [Complete `1.22.0` Changeset](https://github.com/Workiva/over_react/compare/1.21.0...1.22.0)

__New Features__
* [#142]: Do not execute prop validation logic in dart2js code

## 1.21.0

> [Complete `1.21.0` Changeset](https://github.com/Workiva/over_react/compare/1.20.2...1.21.0)

__New Features__
* [#140]: Add an option to make `BuiltReduxUiComponent` "pure"

## 1.20.2

> [Complete `1.20.2` Changeset](https://github.com/Workiva/over_react/compare/1.20.1...1.20.2)

__Tech Debt__
* [#137]: Get rid of dart2js compiler warnings

## 1.20.1

> [Complete `1.20.1` Changeset](https://github.com/Workiva/over_react/compare/1.20.0...1.20.1)

__Misc__
* [#133]: Update logger name standard.

## 1.20.0

> [Complete `1.20.0` Changeset](https://github.com/Workiva/over_react/compare/1.19.0...1.20.0)

__New Features__
* [#128]: Add `UiPropsMapView`.

__Misc__
* [#129]: Add CODEOWNERS file.

## 1.19.0

> [Complete `1.19.0` Changeset](https://github.com/Workiva/over_react/compare/1.18.1...1.19.0)

__Dependency Updates__

* [#126]: Update minimum Dart SDK version to `1.24.2`.

__New Features__
* [#118]: Add `BuiltReduxUiComponent` and `BuiltReduxUiProps`.
  - These classes are considered unstable and can be imported via `import "package:over_react/experimental.dart";`

__Tech Debt__
* [#126]: Use dependency_validator.

## 1.18.1

> [Complete `1.18.1` Changeset](https://github.com/Workiva/over_react/compare/1.18.0...1.18.1)

__Bug fixes__
* Fix regression in `prop_mixins.dart` introduced by [#119].

## 1.18.0

> [Complete `1.18.0` Changeset](https://github.com/Workiva/over_react/compare/1.17.0...1.18.0)

__Improvements__
* [#177]: Improve error message when UiState classes aren't set up properly.

__New Features__
* [#119]: More convenient ubiquitous access of DOM/aria props.
* [#120]: Transition in/out-specific config, test attributes.

## 1.17.0

> [Complete `1.17.0` Changeset](https://github.com/Workiva/over_react/compare/1.16.2...1.17.0)

__New Features__

* [#115]: Add 4-argument callback utils

## 1.16.2

> [Complete `1.16.2` Changeset](https://github.com/Workiva/over_react/compare/1.16.1...1.16.2)

__Bug fixes__

* [#110]: Revert bugfixes that can cause FluxUiComponent rendering regressions:
    * ~~[#108]: Fix case where `setState` and store trigger only result in one `FluxUiComponent` render~~
    * ~~[#103]: `FluxUiComponent` redraws only once when store triggers along with ancestor rerender.~~

## 1.16.1

> [Complete `1.16.1` Changeset](https://github.com/Workiva/over_react/compare/1.16.0...1.16.1)

__Bug fixes__

* [#108]: Fix case where `setState` and store trigger only result in one `FluxUiComponent` render

## 1.16.0

> [Complete `1.16.0` Changeset](https://github.com/Workiva/over_react/compare/1.15.1...1.16.0)

__Dependency Updates__

* w_common `^1.8.0` (was `^1.6.0`)
* w_flux `^2.9.0` (was `^2.7.1`)

__New Features__

* [#104]: Update `UiComponent` to implement `DisposableManagerV6`.


__Improvements__

* [#103]: `FluxUiComponent` redraws only once when store triggers along with ancestor rerender.


__Tech Debt__

* [#105]: Add warning for incorrect usage of `getDartComponent`.

&nbsp;

## 1.15.1

> [Complete `1.15.1` Changeset](https://github.com/Workiva/over_react/compare/1.15.0...1.15.1)

__Tech Debt__

* [#97]: Improve some documentation comments.
* [#95]: Move internal test utils to [over_react_test](https://github.com/Workiva/over_react_test/pull/11), and consume them.

&nbsp;

## 1.15.0

> [Complete `1.15.0` Changeset](https://github.com/Workiva/over_react/compare/1.14.0...1.15.0)

__New Features__

* [#88]: Add `validateProps` method to `UiComponent`
  * Will automatically validate props annotated with `@requiredProp`
    within `componentWillMount` and `componentWillReceiveProps`

__Tech Debt__

* [#94]: Address deprecations from `package:test`
* [#98]: Fix misleading typo in overridden parameter name

__Misc__

* [#73]: Add callout for the [OverReact Snippet VS Code Extension](https://marketplace.visualstudio.com/items?itemName=JaceHensley.over-react-snippets)

&nbsp;

## 1.14.0

> [Complete `1.14.0` Changeset](https://github.com/Workiva/over_react/compare/1.13.0...1.14.0)

__Dependency Updates__

* react `^3.4.3` (was `^3.4.1`)
* w_common `^1.6.0` (new)

__New Features__

* [#91]: Implement [`DisposableManagerV3`](https://github.com/Workiva/w_common/blob/master/lib/src/common/disposable_manager.dart#L71) for `UiComponent`
  * Assists with cleaning up streams and other data structures that won't
    necessarily be garbage collected without some manual intervention.

__Misc__

* [#92]: Update prop error message to make it more DDC friendly

&nbsp;

## 1.13.0

> [Complete `1.13.0` Changeset](https://github.com/Workiva/over_react/compare/1.12.1...1.13.0)

__Dependency Updates__

* [#89]: quiver `>=0.21.4 <0.26.0` (was `>=0.21.4 <0.25.0`)

__New Features__

* [#87]: Make `DomProps`/`SvgProps` implement `UiProps` for more convenient DDC typing

__Misc__

* [#86]: Get tests passing using the DDC
* [#83]: Use `over_react_test`

&nbsp;

## 1.12.1

> [Complete `1.12.1` Changeset](https://github.com/Workiva/over_react/compare/1.12.0...1.12.1)

__Bug fixes__

- Bump min source_span to version w/ `SourceFile.fromString`

&nbsp;

## 1.12.0

> [Complete `1.12.0` Changeset](https://github.com/Workiva/over_react/compare/1.11.2...1.12.0)

__Strong Mode / Dart Dev Compiler__

* [#81]: Make transformer output strong mode clean.
  * Closes [#14]
* [#82]: Implement workarounds necessary to make OverReact-based code able to be compiled by the Dart Dev Compiler _("DDC")_.
  * _See new [transformer options documentation](https://github.com/Workiva/over_react/blob/master/lib/src/transformer/README.md#transformer-options) for more information._

&nbsp;

## 1.11.2

> [Complete `1.11.2` Changeset](https://github.com/Workiva/over_react/compare/1.11.1...1.11.2)

__Bug Fixes__

* [e805b7](https://github.com/Workiva/over_react/commit/e805b79b56f90989194ebf0a7951357e7b40f75c): Null-coalesce `isDisposedOrDisposing` to ease consumer test breakages.

&nbsp;

## 1.11.1

> [Complete `1.11.1` Changeset](https://github.com/Workiva/over_react/compare/1.11.0...1.11.1)

__Bug Fixes__

* Revert _[#77]: Update `FluxUiComponent` subscriptions when new `props` are received._
    * Reverted since this broke subclasses that weren't calling super in lifecycle methods `componentWillReceieveProps` and `componentDidUpdate`
    * Keep `@mustCallSuper` annotations from this changeset

&nbsp;

## 1.11.0

> [Complete `1.11.0` Changeset](https://github.com/Workiva/over_react/compare/1.10.0...1.11.0)

__New Features__

* [#76]: Add support for [`covariant`](http://news.dartlang.org/2017/02/dart-122-faster-tools-assert-messages.html) props / state fields.
  * Closes [#49]

__Bug Fixes__

* [#77]: Update `FluxUiComponent` subscriptions when new `props` are received.

__Tech Debt Paid__

* [#75]: Audit the lib for any memory leak sources, and fortify it against future ones.

__Misc__

* [#72]: Add logging message when a race condition causes `BatchedRedraws` to mount a `FluxUiComponent` asynchronously after the `store` has already been disposed.
    * _Thanks @tomconnell-wf!_

&nbsp;

## 1.10.0

> [Complete `1.10.0` Changeset](https://github.com/Workiva/over_react/compare/1.9.2...1.10.0)

__Improvements__

* [#69]: New top-level `getSelectionStart` function to normalize `selectionStart` across browsers for both
  `TextInputElement`s and `TextAreaElement`s


__Tech Debt Paid__

* [#68]: Declare explicitly-used transitive imports in `pubspec.yaml`
* [#70]: Don't run `ValidationUtil`-related tests in dart2js

&nbsp;

## 1.9.2

> [Complete `1.9.2` Changeset](https://github.com/Workiva/over_react/compare/1.9.1...1.9.2)

__Dependency Updates__

* analyzer `>=0.26.1+3 <0.31.0` (was `>=0.26.1+3 <0.30.0`)

&nbsp;

## 1.9.1

> [Complete `1.9.1` Changeset](https://github.com/Workiva/over_react/compare/1.9.0...1.9.1)

__Bug Fixes__

* [#66]: Fix regression with transitions not completing in consumers of `AbstractTransitionComponent` that don't call `super.componentDidMount`

&nbsp;

## 1.9.0

> [Complete `1.9.0` Changeset](https://github.com/Workiva/over_react/compare/1.8.0...1.9.0)

__Improvements__

* [#60]: Provide easy access to DOM node in `ValidationUtil.warn` messages
* [#61]: Export some `react` library members and add capturing event handlers
  * Export `setClientConfiguration` and `ReactElement`
  * Export all `Synthetic*Event` classes
  * Add capturing event handlers supported by ReactJS


__Bug Fixes__

* [#58]: Fix issue with the `transitionend` warning (_added via [#55]_) sometimes firing when it shouldn't
* [#59]: Ensure `AbstractTransitionComponent` does not call `setState` while in the process of unmounting
  * _Thanks @joshbeam-wf!!!_
* [#65] Work around Dart 1.23 strong mode issue with `MapViewMixin`


&nbsp;

## 1.8.0

> [Complete `1.8.0` Changeset](https://github.com/Workiva/over_react/compare/1.7.0...1.8.0)

__Bug Fixes__

* [#54]: Fix strong mode warning
* [#55]: Fix issue with `AbstractTransitionComponent` causing components to hang when the `transitionend` event never fires.


&nbsp;

## 1.7.0

> [Complete `1.7.0` Changeset](https://github.com/Workiva/over_react/compare/1.6.0...1.7.0)

__Deprecations__

* [#51]: Deprecate the `@Required()` annotation since it conflicts with the `meta` package. Replaced by:
    * arguments to the `Accessor` annotation:
        ```dart
        @Accessor(isRequired: true, isNullable: true, requiredErrorMessage: 'foo')
        ```

    * shorthand aliases: `@requiredProp`/`@nullableRequiredProp`

__Bug Fixes__

* [#52]: Eliminate dart2js warnings on component props classes


&nbsp;

## 1.6.0

> [Complete `1.6.0` Changeset](https://github.com/Workiva/over_react/compare/1.5.0...1.6.0)

* [#48]: Improved `getProps()` functionality.
  * Allows you to traverse wrapper components by setting the named parameter `traverseWrappers` to `true`.


&nbsp;

## 1.5.0

> [Complete `1.5.0` Changeset](https://github.com/Workiva/over_react/compare/1.4.0...1.5.0)

__Improvements__

* [#46]: Add `ResizeSensorProps.quickMount` flag for better performance when sensors are mounted often
* Make `getProp`, `getProps`, and `modifyProps` conditional based on the named parameter `shouldAdd`/`shouldModify`.

__Dependency Updates__

* Add missing quiver dependency (now depends on quiver `>=0.21.4 <0.25.0`)
* Broaden analyzer dependency range to `>=0.26.1+3 <0.30.0` (was `>=0.26.1+3 <0.28.0`)



&nbsp;

## 1.4.0

> [Complete `1.4.0` Changeset](https://github.com/Workiva/over_react/compare/1.3.0...1.4.0)

__[#40]: Sync changes from original private repo library__
  > _This is the last time we'll do this - as the original library has now been completely switched over to use `over_react`_

  * __Switched dependency__ from `browser_detect` to our
  [new `platform_detect` library](https://github.com/Workiva/platform_detect)!

  * __Improved__ `toString` method of `DebugFriendlyConstant`.
  * __Improved__ `setSelectionRange` polyfill to avoid https://github.com/dart-lang/sdk/issues/22967

  * __Added__ typedef for `ElementCallback` and `ResizeSensorHandler`.
  * __Added__ `newStyleFromProps` utility function.
  * __Added__ `getPropKey` utility function.
    * Allows you to get a namespaced prop key dynamically!



__Miscellaneous__

  * [#28]: Run unit tests in dart2js on CI
  * [#37]: Update formatting guidelines WRT dartfmt and trailing commas


&nbsp;

## 1.3.0

> [Complete `1.3.0` Changeset](https://github.com/Workiva/over_react/compare/1.2.0...1.3.0)

__React JS Upgrade__

  * [#31]: Upgrade to
    [React JS `15.4.x`](https://github.com/facebook/react/releases/tag/v15.4.0) via
    [react-dart `3.1.0`](https://github.com/cleandart/react-dart/pull/108).
  * [#27]: Add missing SVG elements
    _(e.g. `Dom.foreignObject` pointed out by @kasperpeulen)_

__We are now on Gitter!__

  * [#33]: Implement vehicle for community discussion
    ([on Gitter](https://gitter.im/over_react/Lobby)).
    _Thanks for [the suggestion](https://github.com/Workiva/over_react/issues/32) @jtrunick!_


&nbsp;

## 1.2.0

> [Complete `1.2.0` Changeset](https://github.com/Workiva/over_react/compare/1.1.1...1.2.0)

__Strong Mode__

  * [#15]: Make `over_react` code "strong mode" compliant!
    * We will be working in the near future to make the code generated by our transformer compliant as well.

__Dependency Updates__

  * [#23]: Update minimum Dart SDK version to `1.19.1`.
  * [#15]: Update minimum `react` package version to `3.0.1`.

__Bug Fixes__

  * [#17]: Add missing `browser_detect` dependency.
    * _Thanks [@denniskaselow](https://github.com/denniskaselow)!_

__Documentation__

  * [#16]: Fix typos in readme.
    * _Thanks [@denniskaselow](https://github.com/denniskaselow) / [@johncblandii](https://github.com/johncblandii)!_
  * [#20]: Improve PR / Issue templates.



&nbsp;

## 1.1.1

> [Complete `1.1.1` Changeset](https://github.com/Workiva/over_react/compare/1.1.0...1.1.1)

  * [#6]: Add contributor documentation.
  * [#7]: Allow "unsupported" units to be passed to the `toRem` and `toPx` functions.



&nbsp;

## 1.1.0

> [Complete `1.1.0` Changeset](https://github.com/Workiva/over_react/compare/1.0.2...1.1.0)

__New Features__

  * [#10]: Add `FluxUiComponent` and `FluxUiStatefulComponent`.
    * Enables consumers to build UI components with a uni-directional data flow via the
      [w_flux](https://github.com/workiva/w_flux) library.

__Misc__

  * [#8]: Add a stateful UI component demo.
  * [#9]: Fix CI build fragility.



&nbsp;

## 1.0.2

> [Complete `1.0.2` Changeset](https://github.com/Workiva/over_react/compare/1.0.1...1.0.2)

  * [#5]: Add some Bootstrap UI components to `web/` to demonstrate what can be built using OverReact.



&nbsp;

## 1.0.1

> [Complete `1.0.1` Changeset](https://github.com/Workiva/over_react/compare/1.0.0...1.0.1)

  * Add test coverage for the `constants`, `dom_util`, `guid_util` and `event_helpers` libraries.



&nbsp;

## 1.0.0

Initial public release of the library.




[#1]: https://github.com/Workiva/over_react/pull/1
[#2]: https://github.com/Workiva/over_react/pull/2
[#3]: https://github.com/Workiva/over_react/pull/3
[#4]: https://github.com/Workiva/over_react/pull/4
[#5]: https://github.com/Workiva/over_react/pull/5
[#6]: https://github.com/Workiva/over_react/pull/6
[#7]: https://github.com/Workiva/over_react/pull/7
[#8]: https://github.com/Workiva/over_react/pull/8
[#9]: https://github.com/Workiva/over_react/pull/9
[#10]: https://github.com/Workiva/over_react/pull/10
[#11]: https://github.com/Workiva/over_react/pull/11
[#12]: https://github.com/Workiva/over_react/pull/12
[#13]: https://github.com/Workiva/over_react/pull/13
[#14]: https://github.com/Workiva/over_react/pull/14
[#15]: https://github.com/Workiva/over_react/pull/15
[#16]: https://github.com/Workiva/over_react/pull/16
[#17]: https://github.com/Workiva/over_react/pull/17
[#18]: https://github.com/Workiva/over_react/pull/18
[#19]: https://github.com/Workiva/over_react/pull/19
[#20]: https://github.com/Workiva/over_react/pull/20
[#21]: https://github.com/Workiva/over_react/pull/21
[#22]: https://github.com/Workiva/over_react/pull/22
[#23]: https://github.com/Workiva/over_react/pull/23
[#24]: https://github.com/Workiva/over_react/pull/24
[#25]: https://github.com/Workiva/over_react/pull/25
[#26]: https://github.com/Workiva/over_react/pull/26
[#27]: https://github.com/Workiva/over_react/pull/27
[#28]: https://github.com/Workiva/over_react/pull/28
[#29]: https://github.com/Workiva/over_react/pull/29
[#30]: https://github.com/Workiva/over_react/pull/30
[#31]: https://github.com/Workiva/over_react/pull/31
[#32]: https://github.com/Workiva/over_react/pull/32
[#33]: https://github.com/Workiva/over_react/pull/33
[#34]: https://github.com/Workiva/over_react/pull/34
[#35]: https://github.com/Workiva/over_react/pull/35
[#36]: https://github.com/Workiva/over_react/pull/36
[#37]: https://github.com/Workiva/over_react/pull/37
[#38]: https://github.com/Workiva/over_react/pull/38
[#39]: https://github.com/Workiva/over_react/pull/39
[#40]: https://github.com/Workiva/over_react/pull/40
[#41]: https://github.com/Workiva/over_react/pull/41
[#42]: https://github.com/Workiva/over_react/pull/42
[#43]: https://github.com/Workiva/over_react/pull/43
[#44]: https://github.com/Workiva/over_react/pull/44
[#45]: https://github.com/Workiva/over_react/pull/45
[#46]: https://github.com/Workiva/over_react/pull/46
[#47]: https://github.com/Workiva/over_react/pull/47
[#48]: https://github.com/Workiva/over_react/pull/48
[#49]: https://github.com/Workiva/over_react/pull/49
[#50]: https://github.com/Workiva/over_react/pull/50
[#51]: https://github.com/Workiva/over_react/pull/51
[#52]: https://github.com/Workiva/over_react/pull/52
[#53]: https://github.com/Workiva/over_react/pull/53
[#54]: https://github.com/Workiva/over_react/pull/54
[#55]: https://github.com/Workiva/over_react/pull/55
[#56]: https://github.com/Workiva/over_react/pull/56
[#57]: https://github.com/Workiva/over_react/pull/57
[#58]: https://github.com/Workiva/over_react/pull/58
[#59]: https://github.com/Workiva/over_react/pull/59
[#60]: https://github.com/Workiva/over_react/pull/60
[#61]: https://github.com/Workiva/over_react/pull/61
[#62]: https://github.com/Workiva/over_react/pull/62
[#63]: https://github.com/Workiva/over_react/pull/63
[#64]: https://github.com/Workiva/over_react/pull/64
[#65]: https://github.com/Workiva/over_react/pull/65
[#66]: https://github.com/Workiva/over_react/pull/66
[#67]: https://github.com/Workiva/over_react/pull/67
[#68]: https://github.com/Workiva/over_react/pull/68
[#69]: https://github.com/Workiva/over_react/pull/69
[#70]: https://github.com/Workiva/over_react/pull/70
[#71]: https://github.com/Workiva/over_react/pull/71
[#72]: https://github.com/Workiva/over_react/pull/72
[#73]: https://github.com/Workiva/over_react/pull/73
[#74]: https://github.com/Workiva/over_react/pull/74
[#75]: https://github.com/Workiva/over_react/pull/75
[#76]: https://github.com/Workiva/over_react/pull/76
[#77]: https://github.com/Workiva/over_react/pull/77
[#78]: https://github.com/Workiva/over_react/pull/78
[#79]: https://github.com/Workiva/over_react/pull/79
[#80]: https://github.com/Workiva/over_react/pull/80
[#81]: https://github.com/Workiva/over_react/pull/81
[#82]: https://github.com/Workiva/over_react/pull/82
[#83]: https://github.com/Workiva/over_react/pull/83
[#84]: https://github.com/Workiva/over_react/pull/84
[#85]: https://github.com/Workiva/over_react/pull/85
[#86]: https://github.com/Workiva/over_react/pull/86
[#87]: https://github.com/Workiva/over_react/pull/87
[#88]: https://github.com/Workiva/over_react/pull/88
[#89]: https://github.com/Workiva/over_react/pull/89
[#90]: https://github.com/Workiva/over_react/pull/90
[#91]: https://github.com/Workiva/over_react/pull/91
[#92]: https://github.com/Workiva/over_react/pull/92
[#93]: https://github.com/Workiva/over_react/pull/93
[#94]: https://github.com/Workiva/over_react/pull/94
[#95]: https://github.com/Workiva/over_react/pull/95
[#96]: https://github.com/Workiva/over_react/pull/96
[#97]: https://github.com/Workiva/over_react/pull/97
[#98]: https://github.com/Workiva/over_react/pull/98
[#99]: https://github.com/Workiva/over_react/pull/99
[#100]: https://github.com/Workiva/over_react/pull/100
[#101]: https://github.com/Workiva/over_react/pull/101
[#102]: https://github.com/Workiva/over_react/pull/102
[#103]: https://github.com/Workiva/over_react/pull/103
[#104]: https://github.com/Workiva/over_react/pull/104
[#105]: https://github.com/Workiva/over_react/pull/105
[#106]: https://github.com/Workiva/over_react/pull/106
[#107]: https://github.com/Workiva/over_react/pull/107
[#108]: https://github.com/Workiva/over_react/pull/108
[#109]: https://github.com/Workiva/over_react/pull/109
[#110]: https://github.com/Workiva/over_react/pull/110
[#111]: https://github.com/Workiva/over_react/pull/111
[#112]: https://github.com/Workiva/over_react/pull/112
[#113]: https://github.com/Workiva/over_react/pull/113
[#114]: https://github.com/Workiva/over_react/pull/114
[#115]: https://github.com/Workiva/over_react/pull/115
[#116]: https://github.com/Workiva/over_react/pull/116
[#117]: https://github.com/Workiva/over_react/pull/117
[#118]: https://github.com/Workiva/over_react/pull/118
[#119]: https://github.com/Workiva/over_react/pull/119
[#120]: https://github.com/Workiva/over_react/pull/120
[#121]: https://github.com/Workiva/over_react/pull/121
[#122]: https://github.com/Workiva/over_react/pull/122
[#123]: https://github.com/Workiva/over_react/pull/123
[#124]: https://github.com/Workiva/over_react/pull/124
[#125]: https://github.com/Workiva/over_react/pull/125
[#126]: https://github.com/Workiva/over_react/pull/126
[#127]: https://github.com/Workiva/over_react/pull/127
[#128]: https://github.com/Workiva/over_react/pull/128
[#129]: https://github.com/Workiva/over_react/pull/129
[#130]: https://github.com/Workiva/over_react/pull/130
[#131]: https://github.com/Workiva/over_react/pull/131
[#132]: https://github.com/Workiva/over_react/pull/132
[#133]: https://github.com/Workiva/over_react/pull/133
[#134]: https://github.com/Workiva/over_react/pull/134
[#135]: https://github.com/Workiva/over_react/pull/135
[#136]: https://github.com/Workiva/over_react/pull/136
[#137]: https://github.com/Workiva/over_react/pull/137
[#138]: https://github.com/Workiva/over_react/pull/138
[#139]: https://github.com/Workiva/over_react/pull/139
[#140]: https://github.com/Workiva/over_react/pull/140
[#141]: https://github.com/Workiva/over_react/pull/141
[#142]: https://github.com/Workiva/over_react/pull/142
[#143]: https://github.com/Workiva/over_react/pull/143
[#144]: https://github.com/Workiva/over_react/pull/144
[#145]: https://github.com/Workiva/over_react/pull/145
[#146]: https://github.com/Workiva/over_react/pull/146
[#147]: https://github.com/Workiva/over_react/pull/147
[#148]: https://github.com/Workiva/over_react/pull/148
[#149]: https://github.com/Workiva/over_react/pull/149
[#150]: https://github.com/Workiva/over_react/pull/150
[#151]: https://github.com/Workiva/over_react/pull/151
[#152]: https://github.com/Workiva/over_react/pull/152
[#153]: https://github.com/Workiva/over_react/pull/153
[#154]: https://github.com/Workiva/over_react/pull/154
[#155]: https://github.com/Workiva/over_react/pull/155
[#156]: https://github.com/Workiva/over_react/pull/156
[#157]: https://github.com/Workiva/over_react/pull/157
[#158]: https://github.com/Workiva/over_react/pull/158
[#159]: https://github.com/Workiva/over_react/pull/159
[#160]: https://github.com/Workiva/over_react/pull/160
[#161]: https://github.com/Workiva/over_react/pull/161
[#162]: https://github.com/Workiva/over_react/pull/162
[#163]: https://github.com/Workiva/over_react/pull/163
[#164]: https://github.com/Workiva/over_react/pull/164
[#165]: https://github.com/Workiva/over_react/pull/165
[#166]: https://github.com/Workiva/over_react/pull/166
[#167]: https://github.com/Workiva/over_react/pull/167
[#168]: https://github.com/Workiva/over_react/pull/168
[#169]: https://github.com/Workiva/over_react/pull/169
[#170]: https://github.com/Workiva/over_react/pull/170
[#171]: https://github.com/Workiva/over_react/pull/171
[#172]: https://github.com/Workiva/over_react/pull/172
[#173]: https://github.com/Workiva/over_react/pull/173
[#174]: https://github.com/Workiva/over_react/pull/174
[#175]: https://github.com/Workiva/over_react/pull/175
[#176]: https://github.com/Workiva/over_react/pull/176
[#177]: https://github.com/Workiva/over_react/pull/177
[#178]: https://github.com/Workiva/over_react/pull/178
[#179]: https://github.com/Workiva/over_react/pull/179
[#180]: https://github.com/Workiva/over_react/pull/180
[#181]: https://github.com/Workiva/over_react/pull/181
[#182]: https://github.com/Workiva/over_react/pull/182
[#183]: https://github.com/Workiva/over_react/pull/183
[#184]: https://github.com/Workiva/over_react/pull/184
[#185]: https://github.com/Workiva/over_react/pull/185
[#186]: https://github.com/Workiva/over_react/pull/186
[#187]: https://github.com/Workiva/over_react/pull/187
[#188]: https://github.com/Workiva/over_react/pull/188
[#189]: https://github.com/Workiva/over_react/pull/189
[#190]: https://github.com/Workiva/over_react/pull/190
[#191]: https://github.com/Workiva/over_react/pull/191
[#192]: https://github.com/Workiva/over_react/pull/192
[#193]: https://github.com/Workiva/over_react/pull/193
[#194]: https://github.com/Workiva/over_react/pull/194
[#195]: https://github.com/Workiva/over_react/pull/195
[#196]: https://github.com/Workiva/over_react/pull/196
[#197]: https://github.com/Workiva/over_react/pull/197
[#198]: https://github.com/Workiva/over_react/pull/198
[#199]: https://github.com/Workiva/over_react/pull/199
[#200]: https://github.com/Workiva/over_react/pull/200
[#201]: https://github.com/Workiva/over_react/pull/201
[#202]: https://github.com/Workiva/over_react/pull/202
[#203]: https://github.com/Workiva/over_react/pull/203
[#204]: https://github.com/Workiva/over_react/pull/204
[#205]: https://github.com/Workiva/over_react/pull/205
[#206]: https://github.com/Workiva/over_react/pull/206
[#207]: https://github.com/Workiva/over_react/pull/207
[#208]: https://github.com/Workiva/over_react/pull/208
[#209]: https://github.com/Workiva/over_react/pull/209
[#210]: https://github.com/Workiva/over_react/pull/210
[#211]: https://github.com/Workiva/over_react/pull/211
[#212]: https://github.com/Workiva/over_react/pull/212
[#213]: https://github.com/Workiva/over_react/pull/213
[#214]: https://github.com/Workiva/over_react/pull/214
[#215]: https://github.com/Workiva/over_react/pull/215
[#216]: https://github.com/Workiva/over_react/pull/216
[#217]: https://github.com/Workiva/over_react/pull/217
[#218]: https://github.com/Workiva/over_react/pull/218
[#219]: https://github.com/Workiva/over_react/pull/219
[#220]: https://github.com/Workiva/over_react/pull/220
[#221]: https://github.com/Workiva/over_react/pull/221
[#222]: https://github.com/Workiva/over_react/pull/222
[#223]: https://github.com/Workiva/over_react/pull/223
[#224]: https://github.com/Workiva/over_react/pull/224
[#225]: https://github.com/Workiva/over_react/pull/225
[#226]: https://github.com/Workiva/over_react/pull/226
[#227]: https://github.com/Workiva/over_react/pull/227
[#228]: https://github.com/Workiva/over_react/pull/228
[#229]: https://github.com/Workiva/over_react/pull/229
[#230]: https://github.com/Workiva/over_react/pull/230
[#231]: https://github.com/Workiva/over_react/pull/231
[#232]: https://github.com/Workiva/over_react/pull/232
[#233]: https://github.com/Workiva/over_react/pull/233
[#234]: https://github.com/Workiva/over_react/pull/234
[#235]: https://github.com/Workiva/over_react/pull/235
[#236]: https://github.com/Workiva/over_react/pull/236
[#237]: https://github.com/Workiva/over_react/pull/237
[#238]: https://github.com/Workiva/over_react/pull/238
[#239]: https://github.com/Workiva/over_react/pull/239
[#240]: https://github.com/Workiva/over_react/pull/240
[#241]: https://github.com/Workiva/over_react/pull/241
[#242]: https://github.com/Workiva/over_react/pull/242
[#243]: https://github.com/Workiva/over_react/pull/243
[#244]: https://github.com/Workiva/over_react/pull/244
[#245]: https://github.com/Workiva/over_react/pull/245
[#246]: https://github.com/Workiva/over_react/pull/246
[#247]: https://github.com/Workiva/over_react/pull/247
[#248]: https://github.com/Workiva/over_react/pull/248
[#249]: https://github.com/Workiva/over_react/pull/249
[#250]: https://github.com/Workiva/over_react/pull/250
[#251]: https://github.com/Workiva/over_react/pull/251
[#252]: https://github.com/Workiva/over_react/pull/252
[#253]: https://github.com/Workiva/over_react/pull/253
[#254]: https://github.com/Workiva/over_react/pull/254
[#255]: https://github.com/Workiva/over_react/pull/255
[#256]: https://github.com/Workiva/over_react/pull/256
[#257]: https://github.com/Workiva/over_react/pull/257
[#258]: https://github.com/Workiva/over_react/pull/258
[#259]: https://github.com/Workiva/over_react/pull/259
[#260]: https://github.com/Workiva/over_react/pull/260
[#261]: https://github.com/Workiva/over_react/pull/261
[#262]: https://github.com/Workiva/over_react/pull/262
[#263]: https://github.com/Workiva/over_react/pull/263
[#264]: https://github.com/Workiva/over_react/pull/264
[#265]: https://github.com/Workiva/over_react/pull/265
[#266]: https://github.com/Workiva/over_react/pull/266
[#267]: https://github.com/Workiva/over_react/pull/267
[#268]: https://github.com/Workiva/over_react/pull/268
[#269]: https://github.com/Workiva/over_react/pull/269
[#270]: https://github.com/Workiva/over_react/pull/270
[#271]: https://github.com/Workiva/over_react/pull/271
[#272]: https://github.com/Workiva/over_react/pull/272
[#273]: https://github.com/Workiva/over_react/pull/273
[#274]: https://github.com/Workiva/over_react/pull/274
[#275]: https://github.com/Workiva/over_react/pull/275
[#276]: https://github.com/Workiva/over_react/pull/276
[#277]: https://github.com/Workiva/over_react/pull/277
[#278]: https://github.com/Workiva/over_react/pull/278
[#279]: https://github.com/Workiva/over_react/pull/279
[#280]: https://github.com/Workiva/over_react/pull/280
[#281]: https://github.com/Workiva/over_react/pull/281
[#282]: https://github.com/Workiva/over_react/pull/282
[#283]: https://github.com/Workiva/over_react/pull/283
[#284]: https://github.com/Workiva/over_react/pull/284
[#285]: https://github.com/Workiva/over_react/pull/285
[#286]: https://github.com/Workiva/over_react/pull/286
[#287]: https://github.com/Workiva/over_react/pull/287
[#288]: https://github.com/Workiva/over_react/pull/288
[#289]: https://github.com/Workiva/over_react/pull/289
[#290]: https://github.com/Workiva/over_react/pull/290
[#291]: https://github.com/Workiva/over_react/pull/291
[#292]: https://github.com/Workiva/over_react/pull/292
[#293]: https://github.com/Workiva/over_react/pull/293
[#294]: https://github.com/Workiva/over_react/pull/294
[#295]: https://github.com/Workiva/over_react/pull/295
[#296]: https://github.com/Workiva/over_react/pull/296
[#297]: https://github.com/Workiva/over_react/pull/297
[#298]: https://github.com/Workiva/over_react/pull/298
[#299]: https://github.com/Workiva/over_react/pull/299
[#300]: https://github.com/Workiva/over_react/pull/300
[#301]: https://github.com/Workiva/over_react/pull/301
[#302]: https://github.com/Workiva/over_react/pull/302
[#303]: https://github.com/Workiva/over_react/pull/303
[#304]: https://github.com/Workiva/over_react/pull/304
[#305]: https://github.com/Workiva/over_react/pull/305
[#306]: https://github.com/Workiva/over_react/pull/306
[#307]: https://github.com/Workiva/over_react/pull/307
[#308]: https://github.com/Workiva/over_react/pull/308
[#309]: https://github.com/Workiva/over_react/pull/309
[#310]: https://github.com/Workiva/over_react/pull/310
[#311]: https://github.com/Workiva/over_react/pull/311
[#312]: https://github.com/Workiva/over_react/pull/312
[#313]: https://github.com/Workiva/over_react/pull/313
[#314]: https://github.com/Workiva/over_react/pull/314
[#315]: https://github.com/Workiva/over_react/pull/315
[#316]: https://github.com/Workiva/over_react/pull/316
[#317]: https://github.com/Workiva/over_react/pull/317
[#318]: https://github.com/Workiva/over_react/pull/318
[#319]: https://github.com/Workiva/over_react/pull/319
[#320]: https://github.com/Workiva/over_react/pull/320
[#321]: https://github.com/Workiva/over_react/pull/321
[#322]: https://github.com/Workiva/over_react/pull/322
[#323]: https://github.com/Workiva/over_react/pull/323
[#324]: https://github.com/Workiva/over_react/pull/324
[#325]: https://github.com/Workiva/over_react/pull/325
[#326]: https://github.com/Workiva/over_react/pull/326
[#327]: https://github.com/Workiva/over_react/pull/327
[#328]: https://github.com/Workiva/over_react/pull/328
[#329]: https://github.com/Workiva/over_react/pull/329
[#330]: https://github.com/Workiva/over_react/pull/330
[#331]: https://github.com/Workiva/over_react/pull/331
[#332]: https://github.com/Workiva/over_react/pull/332
[#333]: https://github.com/Workiva/over_react/pull/333
[#334]: https://github.com/Workiva/over_react/pull/334
[#335]: https://github.com/Workiva/over_react/pull/335
[#336]: https://github.com/Workiva/over_react/pull/336
[#337]: https://github.com/Workiva/over_react/pull/337
[#338]: https://github.com/Workiva/over_react/pull/338
[#339]: https://github.com/Workiva/over_react/pull/339
[#340]: https://github.com/Workiva/over_react/pull/340
[#341]: https://github.com/Workiva/over_react/pull/341
[#342]: https://github.com/Workiva/over_react/pull/342
[#343]: https://github.com/Workiva/over_react/pull/343
[#344]: https://github.com/Workiva/over_react/pull/344
[#345]: https://github.com/Workiva/over_react/pull/345
[#346]: https://github.com/Workiva/over_react/pull/346
[#347]: https://github.com/Workiva/over_react/pull/347
[#348]: https://github.com/Workiva/over_react/pull/348
[#349]: https://github.com/Workiva/over_react/pull/349
[#350]: https://github.com/Workiva/over_react/pull/350
[#351]: https://github.com/Workiva/over_react/pull/351
[#352]: https://github.com/Workiva/over_react/pull/352
[#353]: https://github.com/Workiva/over_react/pull/353
[#354]: https://github.com/Workiva/over_react/pull/354
[#355]: https://github.com/Workiva/over_react/pull/355
[#356]: https://github.com/Workiva/over_react/pull/356
[#357]: https://github.com/Workiva/over_react/pull/357
[#358]: https://github.com/Workiva/over_react/pull/358
[#359]: https://github.com/Workiva/over_react/pull/359
[#360]: https://github.com/Workiva/over_react/pull/360
[#361]: https://github.com/Workiva/over_react/pull/361
[#362]: https://github.com/Workiva/over_react/pull/362
[#363]: https://github.com/Workiva/over_react/pull/363
[#364]: https://github.com/Workiva/over_react/pull/364
[#365]: https://github.com/Workiva/over_react/pull/365
[#366]: https://github.com/Workiva/over_react/pull/366
[#367]: https://github.com/Workiva/over_react/pull/367
[#368]: https://github.com/Workiva/over_react/pull/368
[#369]: https://github.com/Workiva/over_react/pull/369
[#370]: https://github.com/Workiva/over_react/pull/370
[#371]: https://github.com/Workiva/over_react/pull/371
[#372]: https://github.com/Workiva/over_react/pull/372
[#373]: https://github.com/Workiva/over_react/pull/373
[#374]: https://github.com/Workiva/over_react/pull/374
[#375]: https://github.com/Workiva/over_react/pull/375
[#376]: https://github.com/Workiva/over_react/pull/376
[#377]: https://github.com/Workiva/over_react/pull/377
[#378]: https://github.com/Workiva/over_react/pull/378
[#379]: https://github.com/Workiva/over_react/pull/379
[#380]: https://github.com/Workiva/over_react/pull/380
[#381]: https://github.com/Workiva/over_react/pull/381
[#382]: https://github.com/Workiva/over_react/pull/382
[#383]: https://github.com/Workiva/over_react/pull/383
[#384]: https://github.com/Workiva/over_react/pull/384
[#385]: https://github.com/Workiva/over_react/pull/385
[#386]: https://github.com/Workiva/over_react/pull/386
[#387]: https://github.com/Workiva/over_react/pull/387
[#388]: https://github.com/Workiva/over_react/pull/388
[#389]: https://github.com/Workiva/over_react/pull/389
[#390]: https://github.com/Workiva/over_react/pull/390
[#391]: https://github.com/Workiva/over_react/pull/391
[#392]: https://github.com/Workiva/over_react/pull/392
[#393]: https://github.com/Workiva/over_react/pull/393
[#394]: https://github.com/Workiva/over_react/pull/394
[#395]: https://github.com/Workiva/over_react/pull/395
[#396]: https://github.com/Workiva/over_react/pull/396
[#397]: https://github.com/Workiva/over_react/pull/397
[#398]: https://github.com/Workiva/over_react/pull/398
[#399]: https://github.com/Workiva/over_react/pull/399
[#400]: https://github.com/Workiva/over_react/pull/400
[#401]: https://github.com/Workiva/over_react/pull/401
[#402]: https://github.com/Workiva/over_react/pull/402
[#403]: https://github.com/Workiva/over_react/pull/403
[#404]: https://github.com/Workiva/over_react/pull/404
[#405]: https://github.com/Workiva/over_react/pull/405
[#406]: https://github.com/Workiva/over_react/pull/406
[#407]: https://github.com/Workiva/over_react/pull/407
[#408]: https://github.com/Workiva/over_react/pull/408
[#409]: https://github.com/Workiva/over_react/pull/409
[#410]: https://github.com/Workiva/over_react/pull/410
[#411]: https://github.com/Workiva/over_react/pull/411
[#412]: https://github.com/Workiva/over_react/pull/412
[#413]: https://github.com/Workiva/over_react/pull/413
[#414]: https://github.com/Workiva/over_react/pull/414
[#415]: https://github.com/Workiva/over_react/pull/415
[#416]: https://github.com/Workiva/over_react/pull/416
[#417]: https://github.com/Workiva/over_react/pull/417
[#418]: https://github.com/Workiva/over_react/pull/418
[#419]: https://github.com/Workiva/over_react/pull/419
[#420]: https://github.com/Workiva/over_react/pull/420
[#421]: https://github.com/Workiva/over_react/pull/421
[#422]: https://github.com/Workiva/over_react/pull/422
[#423]: https://github.com/Workiva/over_react/pull/423
[#424]: https://github.com/Workiva/over_react/pull/424
[#425]: https://github.com/Workiva/over_react/pull/425
[#426]: https://github.com/Workiva/over_react/pull/426
[#427]: https://github.com/Workiva/over_react/pull/427
[#428]: https://github.com/Workiva/over_react/pull/428
[#429]: https://github.com/Workiva/over_react/pull/429
[#430]: https://github.com/Workiva/over_react/pull/430
[#431]: https://github.com/Workiva/over_react/pull/431
[#432]: https://github.com/Workiva/over_react/pull/432
[#433]: https://github.com/Workiva/over_react/pull/433
[#434]: https://github.com/Workiva/over_react/pull/434
[#435]: https://github.com/Workiva/over_react/pull/435
[#436]: https://github.com/Workiva/over_react/pull/436
[#437]: https://github.com/Workiva/over_react/pull/437
[#438]: https://github.com/Workiva/over_react/pull/438
[#439]: https://github.com/Workiva/over_react/pull/439
[#440]: https://github.com/Workiva/over_react/pull/440
[#441]: https://github.com/Workiva/over_react/pull/441
[#442]: https://github.com/Workiva/over_react/pull/442
[#443]: https://github.com/Workiva/over_react/pull/443
[#444]: https://github.com/Workiva/over_react/pull/444
[#445]: https://github.com/Workiva/over_react/pull/445
[#446]: https://github.com/Workiva/over_react/pull/446
[#447]: https://github.com/Workiva/over_react/pull/447
[#448]: https://github.com/Workiva/over_react/pull/448
[#449]: https://github.com/Workiva/over_react/pull/449
[#450]: https://github.com/Workiva/over_react/pull/450
[#451]: https://github.com/Workiva/over_react/pull/451
[#452]: https://github.com/Workiva/over_react/pull/452
[#453]: https://github.com/Workiva/over_react/pull/453
[#454]: https://github.com/Workiva/over_react/pull/454
[#455]: https://github.com/Workiva/over_react/pull/455
[#456]: https://github.com/Workiva/over_react/pull/456
[#457]: https://github.com/Workiva/over_react/pull/457
[#458]: https://github.com/Workiva/over_react/pull/458
[#459]: https://github.com/Workiva/over_react/pull/459
[#460]: https://github.com/Workiva/over_react/pull/460
[#461]: https://github.com/Workiva/over_react/pull/461
[#462]: https://github.com/Workiva/over_react/pull/462
[#463]: https://github.com/Workiva/over_react/pull/463
[#464]: https://github.com/Workiva/over_react/pull/464
[#465]: https://github.com/Workiva/over_react/pull/465
[#466]: https://github.com/Workiva/over_react/pull/466
[#467]: https://github.com/Workiva/over_react/pull/467
[#468]: https://github.com/Workiva/over_react/pull/468
[#469]: https://github.com/Workiva/over_react/pull/469
[#470]: https://github.com/Workiva/over_react/pull/470
[#471]: https://github.com/Workiva/over_react/pull/471
[#472]: https://github.com/Workiva/over_react/pull/472
[#473]: https://github.com/Workiva/over_react/pull/473
[#474]: https://github.com/Workiva/over_react/pull/474
[#475]: https://github.com/Workiva/over_react/pull/475
[#476]: https://github.com/Workiva/over_react/pull/476
[#477]: https://github.com/Workiva/over_react/pull/477
[#478]: https://github.com/Workiva/over_react/pull/478
[#479]: https://github.com/Workiva/over_react/pull/479
[#480]: https://github.com/Workiva/over_react/pull/480
[#481]: https://github.com/Workiva/over_react/pull/481
[#482]: https://github.com/Workiva/over_react/pull/482
[#483]: https://github.com/Workiva/over_react/pull/483
[#484]: https://github.com/Workiva/over_react/pull/484
[#485]: https://github.com/Workiva/over_react/pull/485
[#486]: https://github.com/Workiva/over_react/pull/486
[#487]: https://github.com/Workiva/over_react/pull/487
[#488]: https://github.com/Workiva/over_react/pull/488
[#489]: https://github.com/Workiva/over_react/pull/489
[#490]: https://github.com/Workiva/over_react/pull/490
[#491]: https://github.com/Workiva/over_react/pull/491
[#492]: https://github.com/Workiva/over_react/pull/492
[#493]: https://github.com/Workiva/over_react/pull/493
[#494]: https://github.com/Workiva/over_react/pull/494
[#495]: https://github.com/Workiva/over_react/pull/495
[#496]: https://github.com/Workiva/over_react/pull/496
[#497]: https://github.com/Workiva/over_react/pull/497
[#498]: https://github.com/Workiva/over_react/pull/498
[#499]: https://github.com/Workiva/over_react/pull/499



