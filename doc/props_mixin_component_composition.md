# Composing Props Mixins Into A Single Component Props API

In our core `UiProps` documentation, the pattern of [composing multiple props mixins into a single component props API](../README.md#with-other-mixins) is introduced.

This example builds on that, showing a lightweight example a common use-case for such composition. 

We'll show three components 

1. A `Foo` component that has its own props API - and default rendering behavior when rendered standalone.
1. A `FooBar` component that has its own props API, in addition to the `Foo` props API. This allows consumers to set props declared in `FooPropsMixin`, which will be forwarded to the `Foo` component it renders.
1. A `FooBaz` component, the functional version of `FooBar`.

### Foo Component
```dart
import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooPropsMixin> Foo = _$Foo; // ignore: undefined_identifier

mixin FooPropsMixin on UiProps {
  Set<int> qux;
}

class FooComponent extends UiComponent2<FooPropsMixin> {
  @override
  get defaultProps => (newProps()
    ..qux = {1, 2, 3}
  );

  @override
  render() {
    return (Dom.div()
      ..modifyProps(addUnconsumedDomProps)
      ..className = (forwardingClassNameBuilder()..add('foo'))
    )(
      'Qux: ', 
      props.qux.map((n) => n),
      props.children,
    );
  }
}
```

__Which, when rendered on its own - produces the following HTML:__

```html
<div class="foo">Qux: 123</div>
```

### Composing Foo using the FooBar component

To compose the `Foo` component using `FooBar`, we'll expose the prop API for both the `FooPropsMixin` and the `BarPropsMixin` like so:
```dart
import 'package:over_react/over_react.dart';
import 'foo.dart';

part 'foo_bar.over_react.g.dart';

UiFactory<FooBarProps> FooBar = _$FooBar; // ignore: undefined_identifier

mixin BarPropsMixin on UiProps {
  bool baz;
  Set<String> bizzles;
}

class FooBarProps = UiProps with BarPropsMixin, FooPropsMixin;

class FooBarComponent extends UiComponent2<FooBarProps> {
  // Only consume the props found within BarPropsMixin, so that any prop values 
  // found in FooPropsMixin get forwarded to the child Foo component via `addUnconsumedProps`.
  @override
  get consumedProps => propsMeta.forMixins({BarPropsMixin});

  @override
  render() {
    return (Foo()
      ..modifyProps(addUnconsumedProps)
      ..className = (forwardingClassNameBuilder()..add('foo__bar'))
    )(
      (Dom.div()..className = 'foo__bar__bizzles')(
        'Bizzles: ',
        Dom.ol()(
          props.bizzles.map(_renderBizzleItem).toList(),
        ),
      ),
    );
  }

  ReactElement _renderBizzleItem(String bizzle) {
    return (Dom.li()..key = bizzle)(bizzle);
  }
}
```

Which, when composed / rendered like so:
```dart
import 'dart:html';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:over_react/over_react.dart';

// An example of where the `FooBar` component might be exported from
import 'package:my_package_name/foobar.dart';

@override
main() {
  final abcFooBar = (FooBar()
    ..className = 'foo_bar--abc'
    ..aria.label = 'I am FooBar!'
    ..qux = {2, 3, 4}
    ..bizzles = {'a', 'b', 'c'}
  )();

  react_dom.render(abcFooBar, querySelector('#some_element_id'));
}
```

Produces the following HTML:
```html
<div class="foo foo__bar foo__bar--abc">
  Qux: 234
  <div class="foo__bar__bizzles">
    Bizzles: 
    <ol>
      <li>a</li>
      <li>b</li>
      <li>c</li>
    </ol>
  </div>
</div>
```

### Composing Foo using the FooBaz component

To compose the `Foo` component using `FooBaz`, a functional component, we'll expose the prop API for both the `FooPropsMixin` and the `BazPropsMixin` like so:
```dart
import 'package:over_react/over_react.dart';
import 'foo.dart';

part 'foo_baz.over_react.g.dart';

mixin BarPropsMixin on UiProps {
  bool baz;
  Set<String> bizzles;
}

class FooBazProps = UiProps with BarPropsMixin, FooPropsMixin;

UiFactory<FooBazProps> FooBaz = uiFunction(
  (props) {
    // Only consume the props found within BarPropsMixin, so that any prop values 
    // found in FooPropsMixin get forwarded to the child Foo component via `addUnconsumedProps`.
    final consumedProps = props.staticMeta.forMixins({BarPropsMixin});

    return (Foo()
      ..addUnconsumedProps(props, consumedProps)
      ..className = (forwardingClassNameBuilder()..add('foo__baz'))
    )(
      (Dom.div()..className = 'foo__baz__bizzles')(
        'Bizzles: ',
        Dom.ol()(
          props.bizzles.map(_renderBizzleItem).toList(),
        ),
      ),
    );
    
    ReactElement _renderBizzleItem(String bizzle) {
      return (Dom.li()..key = bizzle)(bizzle);
    }
  },
  _$FooBazConfig, // ignore: undefined_identifier
);
```

Which, when composed / rendered like so:
```dart
import 'dart:html';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:over_react/over_react.dart';

// An example of where the `FooBaz` component might be exported from
import 'package:my_package_name/foobaz.dart';

@override
main() {
  final abcFooBaz = (FooBaz()
    ..className = 'foo_baz--abc'
    ..aria.label = 'I am FooBaz!'
    ..qux = {2, 3, 4}
    ..bizzles = {'a', 'b', 'c'}
  )();

  react_dom.render(abcFooBaz, querySelector('#some_element_id'));
}
```

Produces the following HTML:
```html
<div class="foo foo__baz foo__baz--abc">
  Qux: 234
  <div class="foo__baz__bizzles">
    Bizzles: 
    <ol>
      <li>a</li>
      <li>b</li>
      <li>c</li>
    </ol>
  </div>
</div>
```

> To learn more about the `consumedProps` behavior shown above, check out the [mixin-based prop forwarding documentation](new_boilerplate_migration.md#updated-default-behavior-in-the-mixin-based-syntax).
