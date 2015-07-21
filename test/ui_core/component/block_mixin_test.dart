library block_mixin_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_components.dart';
import 'package:w_ui_platform/ui_core.dart';

import '../../test_util/react_util.dart';
import '../../test_util/custom_matchers.dart';

/// Main entry point for BlockMixin testing
main() {
  group('BlockMixin', () {
    group('has the correct CSS class names when the', () {
      test('size prop is set', () {
        var renderedNode = renderAndGetDom(Block()..size = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-block-1'));
      });

      test('smSize prop is set', () {
        var renderedNode = renderAndGetDom(Block()..smSize = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-block-sm-1'));
      });

      test('mdSize prop is set', () {
        var renderedNode = renderAndGetDom(Block()..mdSize = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-block-md-1'));
      });

      test('lgSize prop is set', () {
        var renderedNode = renderAndGetDom(Block()..lgSize = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-block-lg-1'));
      });

      test('order prop is set', () {
        var renderedNode = renderAndGetDom(Block()..order = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-order-1'));
      });

      test('smOrder prop is set', () {
        var renderedNode = renderAndGetDom(Block()..smOrder = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-order-sm-1'));
      });

      test('mdOrder prop is set', () {
        var renderedNode = renderAndGetDom(Block()..mdOrder = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-order-md-1'));
      });

      test('lgOrder prop is set', () {
        var renderedNode = renderAndGetDom(Block()..lgOrder = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-order-lg-1'));
      });

      test('offset prop is set', () {
        var renderedNode = renderAndGetDom(Block()..offset = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-offset-1'));
      });

      test('smOffset prop is set', () {
        var renderedNode = renderAndGetDom(Block()..smOffset = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-offset-sm-1'));
      });

      test('mdOffset prop is set', () {
        var renderedNode = renderAndGetDom(Block()..mdOffset = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-offset-md-1'));
      });

      test('lgOffset prop is set', () {
        var renderedNode = renderAndGetDom(Block()..lgOffset = 1);
        expect(renderedNode, hasExactClasses('grid-block grid-offset-lg-1'));
      });

      test('content prop is set', () {
        var renderedNode = renderAndGetDom(Block()..content = true);
        expect(renderedNode, hasExactClasses('grid-block grid-content'));
      });

      test('smContent prop is set', () {
        var renderedNode = renderAndGetDom(Block()..smContent = true);
        expect(renderedNode, hasExactClasses('grid-block grid-content-sm'));
      });

      test('mdContent prop is set', () {
        var renderedNode = renderAndGetDom(Block()..mdContent = true);
        expect(renderedNode, hasExactClasses('grid-block grid-content-md'));
      });

      test('lgContent prop is set', () {
        var renderedNode = renderAndGetDom(Block()..lgContent = true);
        expect(renderedNode, hasExactClasses('grid-block grid-content-lg'));
      });

      test('shrink prop is set', () {
        var renderedNode = renderAndGetDom(Block()..shrink = true);
        expect(renderedNode, hasExactClasses('grid-block grid-shrink'));
      });

      test('smShrink prop is set', () {
        var renderedNode = renderAndGetDom(Block()..smShrink = true);
        expect(renderedNode, hasExactClasses('grid-block grid-shrink-sm'));
      });

      test('mdShrink prop is set', () {
        var renderedNode = renderAndGetDom(Block()..mdShrink = true);
        expect(renderedNode, hasExactClasses('grid-block grid-shrink-md'));
      });

      test('lgShrink prop is set', () {
        var renderedNode = renderAndGetDom(Block()..lgShrink = true);
        expect(renderedNode, hasExactClasses('grid-block grid-shrink-lg'));
      });

      group('collapse prop is', () {
        test('BlockCollapse.NONE', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.NONE);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockCollapse.ALL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.ALL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse'));
        });

        test('BlockCollapse.TOP', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.TOP);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-top'));
        });

        test('BlockCollapse.BOTTOM', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.BOTTOM);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-bottom'));
        });

        test('BlockCollapse.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.LEFT);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-left'));
        });

        test('BlockCollapse.RIGHT', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.RIGHT);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-right'));
        });

        test('BlockCollapse.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-horizontal'));
        });

        test('BlockCollapse.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-vertical'));
        });

        test('BlockCollapse.TOP | BlockCollapse.BOTTOM', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.TOP | BlockCollapse.BOTTOM);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-horizontal'));
        });

        test('BlockCollapse.RIGHT | BlockCollapse.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.RIGHT | BlockCollapse.LEFT);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-vertical'));
        });

        test('BlockCollapse.TOP | BlockCollapse.RIGHT', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.TOP | BlockCollapse.RIGHT);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-top grid-collapse-right'));
        });

        test('BlockCollapse.TOP | BlockCollapse.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.TOP | BlockCollapse.LEFT);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-top grid-collapse-left'));
        });

        test('BlockCollapse.BOTTOM | BlockCollapse.RIGHT', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.BOTTOM | BlockCollapse.RIGHT);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-bottom grid-collapse-right'));
        });

        test('BlockCollapse.BOTTOM | BlockCollapse.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.BOTTOM | BlockCollapse.LEFT);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-bottom grid-collapse-left'));
        });

        test('BlockCollapse.TOP | BlockCollapse.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.TOP | BlockCollapse.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-horizontal'));
        });

        test('BlockCollapse.BOTTOM | BlockCollapse.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.BOTTOM | BlockCollapse.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-horizontal'));
        });

        test('BlockCollapse.RIGHT | BlockCollapse.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.RIGHT | BlockCollapse.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-vertical'));
        });

        test('BlockCollapse.LEFT | BlockCollapse.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.LEFT | BlockCollapse.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-vertical'));
        });
      });

      group('gutter prop is', () {
        test('BlockGutter.NONE', () {
          var renderedNode = renderAndGetDom(Block()..gutter = BlockGutter.NONE);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('BlockGutter.ALL', () {
          var renderedNode = renderAndGetDom(Block()..gutter = BlockGutter.ALL);
          expect(renderedNode, hasExactClasses('grid-block grid-gutter'));
        });

        test('BlockGutter.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..gutter = BlockGutter.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-gutter-horizontal'));
        });

        test('BlockGutter.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..gutter = BlockGutter.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-gutter-vertical'));
        });
      });

      group('scroll prop is', () {
        test('true', () {
          var renderedNode = renderAndGetDom(Block()..scroll = true);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('false', () {
          var renderedNode = renderAndGetDom(Block()..scroll = false);
          expect(renderedNode, hasExactClasses('grid-block no-scroll'));
        });
      });
    });
  });
}
