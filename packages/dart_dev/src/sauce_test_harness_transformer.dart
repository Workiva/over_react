// Based on https://github.com/dart-lang/test/blob/0.12.11/lib/pub_serve.dart
//
// Copyright 2014, the Dart project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:barback/barback.dart';
import 'package:fluri/fluri.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:path/path.dart' as p;

/// A transformer that injects bootstrapping code used by the test runner to run
/// tests against a "pub serve" instance.
///
/// This doesn't modify existing code at all, it just adds test harness files and metadata that
/// can be used when loading tests in iframes.
///
/// Outputs:
///
/// - In: `foo.dart`
///
///     - Out: `foo.dart.sauce_browser_test.dart`, a new file.
///         - Manually sets up `test` package's `Declarer`/`Engine` so that
///             the platform selector specified via query params is respected.
///         - Imports the original `.dart` file and runs the tests in its `main` function
///             using the previously mentioned `Declarer`/`Engine`.
///
/// - In: `foo.html`
///
///     - Out: `foo.html.sauce_browser_test.html`, a modified version of `foo.html`.
///         - `<link rel="x-dart-test" ...>` are replaced with `<script type="application/dart" ...>`.
///         - Includes JS that forwards calls to `console.log` to the parent iframe via `postMessage`.
///
///     - Out: `foo.dart.sauce_browser_test.json`, a new file.
///         - Contains a list of files referred to by `<link rel="x-dart-test" ...>`.
///
class SauceTestHarnessTransformer extends Transformer
    implements DeclaringTransformer {
  final allowedExtensions = '.dart .html';

  static const String sauceDartExtension = '.sauce_browser_test.dart';
  static const String sauceHtmlExtension = '.sauce_browser_test.html';
  static const String sauceDartListExtension = '.dart_file_list.json';
  static const List<String> proxiedIframeRunnerFiles = const <String>[
    'sauce_iframe_runner.css',
    'sauce_iframe_runner.dart',
    'sauce_iframe_runner.html'
  ];

  SauceTestHarnessTransformer.asPlugin();

  void declareOutputs(DeclaringTransform transform) {
    var id = transform.primaryId;

    if (id.extension == '.html') {
      transform.declareOutput(id.addExtension(sauceHtmlExtension));
      transform.declareOutput(id.addExtension(sauceDartListExtension));
    } else if (id.extension == '.dart') {
      transform.declareOutput(id.addExtension(sauceDartExtension));
    }
  }

  var proxied = true;

  Future apply(Transform transform) async {
    var id = transform.primaryInput.id;

    if (id.extension == '.html' &&
        !proxiedIframeRunnerFiles.contains(id.path)) {
      await generateHtml(transform);
    } else if (id.extension == '.dart' &&
        !proxiedIframeRunnerFiles.contains(id.path)) {
      await generateDart(transform);
    }

    if (!proxiedIframeRunnerFiles.contains(id.path) && proxied) {
      var package = transform.primaryInput.id.package;

      for (String proxiedFile in proxiedIframeRunnerFiles) {
        var file = new File(
            'packages/dart_dev/src/tasks/saucelabs/sauce_iframe_runner/$proxiedFile');
        var assetId =
            new AssetId(package, 'test/sauce_iframe_runner/$proxiedFile');
        var asset = new Asset.fromStream(assetId, file.openRead());
        transform.addOutput(asset);
      }
      proxied = false;
    }
  }

  Future generateHtml(Transform transform) async {
    var html =
        new HtmlParser(await transform.primaryInput.readAsString()).parse();

    // Undo the test transformer's change from "packages/browser/dart.js" to "packages/test/dart.js"
    html.querySelectorAll('script').forEach((Element script) {
      var src = script.attributes['src'];
      if (src != null && new RegExp(r'packages/[^"]+/dart.js').hasMatch(src)) {
        script.attributes['src'] = 'packages/browser/dart.js';
      }
    });

    var dartScripts = [];

    // Change the Dart test file's <link rel="x-dart-test"> to a real <script> tag.
    html.querySelectorAll('link[rel="x-dart-test"]').forEach((Element link) {
      var dartScriptFluri = new Fluri(link.attributes['href'])
        ..appendToPath(sauceDartExtension);

      var dartScriptUrl = dartScriptFluri.toString();

      dartScripts.add(dartScriptUrl);

      var script = new Element.tag('script');
      script.attributes
        ..['type'] = 'application/dart'
        ..['src'] = dartScriptUrl;

      link.replaceWith(script);
    });

    // Reroute the logs via `postMessage` to the test runner so they can be parsed.
    var head = html.querySelector('head');
    head.insertBefore(new Element.html('''
      <script type="application/javascript">
        // Send all logs to the parent test runner window.
        console._log_old = console.log;
        console.log = function(msg) {
          window.parent.postMessage(msg, '*');
        };
      </script>
    '''), head.firstChild);

    var id = transform.primaryInput.id;

    transform.addOutput(new Asset.fromString(
        id.addExtension(sauceHtmlExtension), html.outerHtml));

    transform.addOutput(new Asset.fromString(
        id.addExtension(sauceDartListExtension), JSON.encode(dartScripts)));
  }

  void generateDart(Transform transform) {
    var id = transform.primaryInput.id;

    transform.addOutput(new Asset.fromString(
        id.addExtension('.sauce_browser_test.dart'),
        '''
          import 'dart:async';
          import 'dart:html';

          import 'package:test/src/backend/declarer.dart';
          import 'package:test/src/backend/test_platform.dart';
          import 'package:test/src/runner/engine.dart';
          import 'package:test/src/runner/environment.dart';
          import 'package:test/src/runner/reporter/expanded.dart';
          import 'package:test/src/runner/runner_suite.dart';

          import "${p.url.basename(id.path)}" as test;

          void main() {
            final String platformIdentifier = Uri.parse(window.location.toString()).queryParameters['platform'];
            if (platformIdentifier == null) {
              throw new ArgumentError('Must specify platform (`test` package platform identifier) '
                  'via the `platform` query string.');
            }

            /// Recreate test runner setup done automatically as part of the lazy-instantiation of
            /// _globalDeclarer in 'package:test/test.dart'.

            final declarer = new Declarer();

            scheduleMicrotask(() async {
              var engine = new Engine.withSuites([
                new RunnerSuite(const SauceBrowserEnvironment(), declarer.build(),
                    path: window.location.href,
                    platform: TestPlatform.find(platformIdentifier)
                )
              ]);

              ExpandedReporter.watch(engine, color: true, printPath: false, printPlatform: false);

              await engine.run();
            });

            declarer.declare(() {
              test.main();
            });
          }

          /// The environment for test suites loaded manually and run in Sauce Labs.
          class SauceBrowserEnvironment implements Environment {
            const SauceBrowserEnvironment();

            @override
            Uri get observatoryUrl =>
                throw new UnsupportedError("SauceBrowserEnvironment.observatoryUrl is not supported.");

            @override
            Uri get remoteDebuggerUrl =>
                throw new UnsupportedError("SauceBrowserEnvironment.remoteDebuggerUrl is not supported.");

            @override
            displayPause() =>
                throw new UnsupportedError("SauceBrowserEnvironment.displayPause is not supported.");

            @override
            bool get supportsDebugging => false;
          }
        '''));
  }
}
