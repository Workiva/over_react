# Composing Props Mixins Into A Single Component Props API

In our core `UiProps` documentation, the pattern of [composing multiple props mixins into a single component props API](../README.md#with-other-mixins) is introduced.

This example builds on that, showing a lightweight example a common use-case for such composition. 

We'll show two components 

1. A `Bar` component that has its own props API - and default rendering behavior when rendered standalone.
2. A `FooBar` component that has its own props API in addition to the `Bar` props API that it will use to allow consumers to compose `Bar` with `FooBar` by forwarding props from `BarPropsMixin` to the `Bar` component it renders.

### Bar Component
```dart
import 'package:over_react/over_react.dart';

UiFactory<BarPropsMixin> Bar = _$Bar;

mixin BarPropsMixin on UiProps {
  Set<int> qux;
}

class BarComponent extends UiComponent2<BarPropsMixin> {
  @override
  get defaultProps => (newProps()
    ..qux = {1, 2, 3}
  );

  @override
  render() {
    return (Dom.div()
      ..modifyProps(addUnconsumedDomProps)
      ..className = (forwardingClassNameBuilder()..add('bar'))
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
<div class="bar">Qux: 123</div>
```

### Composing Bar using the FooBar component

To compose the `Bar` component using `FooBar`, we'll expose the prop API for both the `BarPropsMixin` and the `FooPropsMixin` like so:
```dart
import 'package:over_react/over_react.dart';
import 'bar.dart';

UiFactory<FooBarProps> FooBar = _$FooBar;

mixin FooPropsMixin on UiProps {
  bool baz;
  Set<String> bizzles;
}

class FooBarProps = UiProps with FooPropsMixin, BarPropsMixin;

class FooBarComponent extends UiComponent2<FooBarProps> {
  @override
  get consumedProps => [
    // Only consume the props found within FooPropsMixin, so that any prop values 
    // found in BarPropsMixin get forwarded to the child Bar component via `addUnconsumedProps`. 
    propsMeta.forMixin(FooPropsMixin),
  ];

  @override
  render() {
    return (Bar()
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
<div class="bar foo__bar foo__bar--abc">
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

> To learn more about the `consumedProps` behavior shown above, check out the [mixin-based prop forwarding documentation](new_boilerplate_migration.md#updated-default-behavior-in-the-mixin-based-syntax).
