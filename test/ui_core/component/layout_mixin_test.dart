library layout_mixin_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_components.dart';
import 'package:w_ui_platform/ui_core.dart';

import '../../test_util/react_util.dart';
import '../../test_util/custom_matchers.dart';

/// Main entry point for LayoutMixin testing
main() {
  group('LayoutMixin', () {
    group('renders with correct CSS classes when the', () {
      test('up prop is set', () {
        var renderedNode = renderAndGetDom(Block()..up = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-up-1'));
      });

      test('smUp prop is set', () {
        var renderedNode = renderAndGetDom(Block()..smUp = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-up-sm-1'));
      });

      test('mdUp prop is set', () {
        var renderedNode = renderAndGetDom(Block()..mdUp = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-up-md-1'));
      });

      test('lgUp prop is set', () {
        var renderedNode = renderAndGetDom(Block()..lgUp = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-up-lg-1'));
      });

      test('wrap prop is set', () {
        var renderedNode = renderAndGetDom(Block()..wrap = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-wrap-1'));
      });

      test('smWrap prop is set', () {
        var renderedNode = renderAndGetDom(Block()..smWrap = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-wrap-sm-1'));
      });

      test('mdWrap prop is set', () {
        var renderedNode = renderAndGetDom(Block()..mdWrap = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-wrap-md-1'));
      });

      test('lgWrap prop is set', () {
        var renderedNode = renderAndGetDom(Block()..lgWrap = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-wrap-lg-1'));
      });

      group('align prop is', () {
        test('BlockAlign.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..align = BlockAlign.LEFT);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockAlign.RIGHT', () {
          var renderedNode = renderAndGetDom(Block()..align = BlockAlign.RIGHT);
          expect(renderedNode, hasExactClasses('grid-block grid-align-right'));
        });

        test('BlockAlign.CENTER', () {
          var renderedNode = renderAndGetDom(Block()..align = BlockAlign.CENTER);
          expect(renderedNode, hasExactClasses('grid-block grid-align-center'));
        });

        test('BlockAlign.JUSTIFIED', () {
          var renderedNode = renderAndGetDom(Block()..align = BlockAlign.JUSTIFIED);
          expect(renderedNode, hasExactClasses('grid-block grid-align-justified'));
        });

        test('BlockAlign.SPACED', () {
          var renderedNode = renderAndGetDom(Block()..align = BlockAlign.SPACED);
          expect(renderedNode, hasExactClasses('grid-block grid-align-spaced'));
        });
      });

      group('smAlign prop is', () {
        test('BlockAlign.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..smAlign = BlockAlign.LEFT);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockAlign.RIGHT', () {
          var renderedNode = renderAndGetDom(Block()..smAlign = BlockAlign.RIGHT);
          expect(renderedNode, hasExactClasses('grid-block grid-align-right-sm'));
        });

        test('BlockAlign.CENTER', () {
          var renderedNode = renderAndGetDom(Block()..smAlign = BlockAlign.CENTER);
          expect(renderedNode, hasExactClasses('grid-block grid-align-center-sm'));
        });

        test('BlockAlign.JUSTIFIED', () {
          var renderedNode = renderAndGetDom(Block()..smAlign = BlockAlign.JUSTIFIED);
          expect(renderedNode, hasExactClasses('grid-block grid-align-justified-sm'));
        });

        test('BlockAlign.SPACED', () {
          var renderedNode = renderAndGetDom(Block()..smAlign = BlockAlign.SPACED);
          expect(renderedNode, hasExactClasses('grid-block grid-align-spaced-sm'));
        });
      });

      group('mdAlign prop is', () {
        test('BlockAlign.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..mdAlign = BlockAlign.LEFT);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockAlign.RIGHT', () {
          var renderedNode = renderAndGetDom(Block()..mdAlign = BlockAlign.RIGHT);
          expect(renderedNode, hasExactClasses('grid-block grid-align-right-md'));
        });

        test('BlockAlign.CENTER', () {
          var renderedNode = renderAndGetDom(Block()..mdAlign = BlockAlign.CENTER);
          expect(renderedNode, hasExactClasses('grid-block grid-align-center-md'));
        });

        test('BlockAlign.JUSTIFIED', () {
          var renderedNode = renderAndGetDom(Block()..mdAlign = BlockAlign.JUSTIFIED);
          expect(renderedNode, hasExactClasses('grid-block grid-align-justified-md'));
        });

        test('BlockAlign.SPACED', () {
          var renderedNode = renderAndGetDom(Block()..mdAlign = BlockAlign.SPACED);
          expect(renderedNode, hasExactClasses('grid-block grid-align-spaced-md'));
        });
      });

      group('lgAlign prop is', () {
        test('BlockAlign.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..lgAlign = BlockAlign.LEFT);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockAlign.RIGHT', () {
          var renderedNode = renderAndGetDom(Block()..lgAlign = BlockAlign.RIGHT);
          expect(renderedNode, hasExactClasses('grid-block grid-align-right-lg'));
        });

        test('BlockAlign.CENTER', () {
          var renderedNode = renderAndGetDom(Block()..lgAlign = BlockAlign.CENTER);
          expect(renderedNode, hasExactClasses('grid-block grid-align-center-lg'));
        });

        test('BlockAlign.JUSTIFIED', () {
          var renderedNode = renderAndGetDom(Block()..lgAlign = BlockAlign.JUSTIFIED);
          expect(renderedNode, hasExactClasses('grid-block grid-align-justified-lg'));
        });

        test('BlockAlign.SPACED', () {
          var renderedNode = renderAndGetDom(Block()..lgAlign = BlockAlign.SPACED);
          expect(renderedNode, hasExactClasses('grid-block grid-align-spaced-lg'));
        });
      });

      group('layout prop is', () {
        test('BlockLayout.NONE', () {
          var renderedNode = renderAndGetDom(Block()..layout = BlockLayout.NONE);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockLayout.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..layout = BlockLayout.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-horizontal'));
        });

        test('BlockAlign.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..layout = BlockLayout.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-vertical'));
        });
      });

      group('smLayout prop is', () {
        test('BlockLayout.NONE', () {
          var renderedNode = renderAndGetDom(Block()..smLayout = BlockLayout.NONE);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockLayout.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..smLayout = BlockLayout.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-horizontal-sm'));
        });

        test('BlockAlign.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..smLayout = BlockLayout.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-vertical-sm'));
        });
      });

      group('mdLayout prop is', () {
        test('BlockLayout.NONE', () {
          var renderedNode = renderAndGetDom(Block()..mdLayout = BlockLayout.NONE);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockLayout.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..mdLayout = BlockLayout.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-horizontal-md'));
        });

        test('BlockAlign.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..mdLayout = BlockLayout.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-vertical-md'));
        });
      });

      group('lgLayout prop is', () {
        test('BlockLayout.NONE', () {
          var renderedNode = renderAndGetDom(Block()..lgLayout = BlockLayout.NONE);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockLayout.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..lgLayout = BlockLayout.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-horizontal-lg'));
        });

        test('BlockAlign.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..lgLayout = BlockLayout.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-vertical-lg'));
        });
      });
    });
  });
}
