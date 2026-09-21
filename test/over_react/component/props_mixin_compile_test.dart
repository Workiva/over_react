@TestOn('browser')
library props_mixin_compile_test;

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:test/test.dart';

part 'props_mixin_compile_test.over_react.g.dart';

void main() {
  group('props mixin compile test -', () {
    test('all non-generated prop mixins can be mixed into a generated props class', () {
      // Use all the components so they don't get tree-shaken out
      expect(() => TestReact(), returnsNormally);
      expect(() => TestDom(), returnsNormally);
      expect(() => TestSvg(), returnsNormally);
      expect(() => TestUbiquitousDom(), returnsNormally);
      expect(() => TestCssClass(), returnsNormally);
      expect(() => TestAria(), returnsNormally);
      expect(() => TestConnectFlux(), returnsNormally);
    });
  });
}

// Regression test: mixing these props mixins into generated props classes
// ensures the $-companion classes compile correctly.

class TestReactProps = UiProps with ReactPropsMixin;
UiFactory<TestReactProps> TestReact = uiFunction((_) {}, _$TestReactConfig);

class TestDomProps = UiProps with DomPropsMixin;
UiFactory<TestDomProps> TestDom = uiFunction((_) {}, _$TestDomConfig);

class TestSvgProps = UiProps with SvgPropsMixin;
UiFactory<TestSvgProps> TestSvg = uiFunction((_) {}, _$TestSvgConfig);

class TestUbiquitousDomProps = UiProps with UbiquitousDomPropsMixin;
UiFactory<TestUbiquitousDomProps> TestUbiquitousDom = uiFunction((_) {}, _$TestUbiquitousDomConfig);

class TestCssClassProps = UiProps with CssClassPropsMixin;
UiFactory<TestCssClassProps> TestCssClass = uiFunction((_) {}, _$TestCssClassConfig);

class TestAriaProps = UiProps with AriaPropsMixin;
UiFactory<TestAriaProps> TestAria = uiFunction((_) {}, _$TestAriaConfig);

class TestConnectFluxProps = UiProps with ConnectFluxPropsMixin;
UiFactory<TestConnectFluxProps> TestConnectFlux = uiFunction((_) {}, _$TestConnectFluxConfig);
