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
      group('size prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..size = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..size = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..size = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-block-1'));
        });
      });

      group('smSize prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..smSize = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..smSize = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..smSize = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-block-sm-1'));
        });
      });

      group('mdSize prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..mdSize = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..mdSize = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..mdSize = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-block-md-1'));
        });
      });

      group('lgSize prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..lgSize = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..lgSize = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..lgSize = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-block-lg-1'));
        });
      });

      group('order prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..order = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..order = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..order = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-order-1'));
        });
      });

      group('smOrder prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..smOrder = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..smOrder = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..smOrder = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-order-sm-1'));
        });
      });

      group('mdOrder prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..mdOrder = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..mdOrder = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..mdOrder = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-order-md-1'));
        });
      });

      group('lgOrder prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..lgOrder = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..lgOrder = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..lgOrder = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-order-lg-1'));
        });
      });

      group('offset prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..offset = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..offset = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..offset = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-offset-1'));
        });
      });

      group('smOffset prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..smOffset = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..smOffset = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..smOffset = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-offset-sm-1'));
        });
      });

      group('mdOffset prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..mdOffset = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..mdOffset = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..mdOffset = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-offset-md-1'));
        });
      });

      group('lgOffset prop is set', () {
        test('to 0', () {
          var renderedNode = renderAndGetDom(Block()..lgOffset = 0);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to null', () {
          var renderedNode = renderAndGetDom(Block()..lgOffset = null);
          expect(renderedNode, hasExactClasses('grid-block'));
        });

        test('to an int larger than 0', () {
          var renderedNode = renderAndGetDom(Block()..lgOffset = 1);
          expect(renderedNode, hasExactClasses('grid-block grid-offset-lg-1'));
        });
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
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-vertical'));
        });

        test('BlockCollapse.RIGHT | BlockCollapse.LEFT', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.RIGHT | BlockCollapse.LEFT);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-horizontal'));
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

        test('BlockCollapse.RIGHT | BlockCollapse.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.RIGHT | BlockCollapse.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-horizontal'));
        });

        test('BlockCollapse.LEFT | BlockCollapse.HORIZONTAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.LEFT | BlockCollapse.HORIZONTAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-horizontal'));
        });

        test('BlockCollapse.TOP | BlockCollapse.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.TOP | BlockCollapse.VERTICAL);
          expect(renderedNode, hasExactClasses('grid-block grid-collapse-vertical'));
        });

        test('BlockCollapse.BOTTOM | BlockCollapse.VERTICAL', () {
          var renderedNode = renderAndGetDom(Block()..collapse = BlockCollapse.BOTTOM | BlockCollapse.VERTICAL);
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
