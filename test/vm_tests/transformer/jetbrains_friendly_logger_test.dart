@TestOn('vm')
library jetbrains_friendly_logger_test;

import 'package:barback/barback.dart';
import 'package:mockito/mockito.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/src/transformer/jetbrains_friendly_logger.dart';

main() {
  group('JetBrainsFriendlyLogger', () {
    MockTransformLogger mockWrappedLogger;
    JetBrainsFriendlyLogger logger;

    setUp(() {
      mockWrappedLogger = new MockTransformLogger();
      logger = new JetBrainsFriendlyLogger(mockWrappedLogger);
    });

    group('clickableReference()', () {
      test('returns a properly-formatted reference to a source span', () {
        SourceFile sourceFile = new SourceFile('line 1\nline 2 TARGET\n line 3', url: 'source_url');
        SourceSpan span = sourceFile.span(sourceFile.getText(0).indexOf('TARGET'));
        String formatted = JetBrainsFriendlyLogger.clickableReference(span);
        expect(formatted, '[source_url 2:8]: ');
      });

      test('returns an empty string when the specified span is null', () {
        expect(JetBrainsFriendlyLogger.clickableReference(null), '');
      });
    });

    group('proxies logs methods,', () {
      SourceSpan span;
      String formattedSpan;
      AssetId asset;
      String message;

      setUp(() {
        SourceFile sourceFile = new SourceFile('source file');

        span = sourceFile.span(0);
        formattedSpan = JetBrainsFriendlyLogger.clickableReference(span);
        asset = new AssetId('package', 'path');
        message = 'message';
      });

      group('prepending the message with the formatted source span when a span is specified:', () {
        test('info()', () {
          logger.info(message, asset: asset, span: span);
          verify(mockWrappedLogger.info(formattedSpan + message, asset: asset));
        });

        test('fine()', () {
          logger.fine(message, asset: asset, span: span);
          verify(mockWrappedLogger.fine(formattedSpan + message, asset: asset));
        });

        test('warning()', () {
          logger.warning(message, asset: asset, span: span);
          verify(mockWrappedLogger.warning(formattedSpan + message, asset: asset));
        });

        test('error()', () {
          logger.error(message, asset: asset, span: span);
          verify(mockWrappedLogger.error(formattedSpan + message, asset: asset));
        });
      });

      group('leaving the message as-is when a span is not specified:', () {
        test('info()', () {
          logger.info(message, asset: asset);
          verify(mockWrappedLogger.info(message, asset: asset));
        });

        test('fine()', () {
          logger.fine(message, asset: asset);
          verify(mockWrappedLogger.fine(message, asset: asset));
        });

        test('warning()', () {
          logger.warning(message, asset: asset);
          verify(mockWrappedLogger.warning(message, asset: asset));
        });

        test('error()', () {
          logger.error(message, asset: asset);
          verify(mockWrappedLogger.error(message, asset: asset));
        });
      });
    });
  });
}

class MockTransformLogger extends Mock implements TransformLogger {
  noSuchMethod(i) => super.noSuchMethod(i);
}
