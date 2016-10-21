// Copyright 2015 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library webdriver.support.forwarder;

import 'dart:async' show Future;
import 'dart:convert' show JSON, UTF8;
import 'dart:io' show ContentType, Directory, File, HttpRequest, HttpStatus;

import 'package:path/path.dart' as path;
import 'package:webdriver/core.dart' show By, WebDriver, WebDriverException;

final _contentTypeJson =
    new ContentType('application', 'json', charset: 'utf-8');

/// Attribute on elements used to locate them on passed WebDriver commands.
const wdElementIdAttribute = 'wd-element-id';

/// [WebDriverForwarder] accepts [HttpRequest]s corresponding to a variation on
/// the WebDriver wire protocol and forwards them to a WebDriver instance.
///
/// The primary difference between this and the standard wire protocol is in
/// the use of WebElement ids. When you need to refer to an element in a request
/// (URI or JSON body), then you should add an 'wd-element-id' attribute to the
/// corresponding element with a unique identifier, and use that identifier as
/// the element id for that element. This class will then search for the
/// corresponding element and in the document and will substitute an actual
/// WebElement id for the given identifier in the request.
///
/// This forwarder supports two additional commands that control how it searches
/// for elements:
///   POST '/enabledeep': enables searching through all Shadow DOMs in the
///     document for the corresponding element (but will fail on browsers that
///     don't support the '/deep/' css selector combinator).
///   POST '/disabledeep': disables searching in Shadow DOMs of the document.
///
/// This forwarder also supports two additional commands for grabbing the
/// browser contents and saving it to the file system.
///   POST '/screenshot': takes a 'file' arg and will capture a screenshot
///     of the browser and save it to the specified file name in [outputDir].
///   POST '/source': takes a 'file' arg and will capture the current page's
///     source and save it to the specified file name in [outputDir].
///
/// See https://code.google.com/p/selenium/wiki/JsonWireProtocol for
/// documentation of other commands.
class WebDriverForwarder {
  /// [WebDriver] instance to forward commands to.
  final WebDriver driver;

  /// Path prefix that all forwarded commands will have.
  final Pattern prefix;

  /// Directory to save screenshots and page source to.
  final Directory outputDir;

  /// Search for elements in all shadow doms of the current document.
  bool useDeep;

  WebDriverForwarder(this.driver,
      {this.prefix: '/webdriver', Directory outputDir, this.useDeep: false})
      : this.outputDir = outputDir == null
            ? Directory.systemTemp.createTempSync()
            : outputDir;

  /// Forward [request] to [driver] and respond to the request with the returned
  /// value or any thrown exceptions.
  Future<Null> forward(HttpRequest request) async {
    try {
      if (!request.uri.path.startsWith(prefix)) {
        request.response.statusCode = HttpStatus.NOT_FOUND;
        return;
      }
      request.response.statusCode = HttpStatus.OK;
      request.response.headers.contentType = _contentTypeJson;

      var endpoint = request.uri.path.replaceFirst(prefix, '');
      if (endpoint.startsWith('/')) {
        endpoint = endpoint.substring(1);
      }
      Map<String, dynamic> params;
      if (request.method == 'POST') {
        String requestBody = await UTF8.decodeStream(request);
        if (requestBody != null && requestBody.isNotEmpty) {
          params = JSON.decode(requestBody) as Map<String, dynamic>;
        }
      }
      var value = await _forward(request.method, endpoint, params);
      request.response
          .add(UTF8.encode(JSON.encode({'status': 0, 'value': value})));
    } on WebDriverException catch (e) {
      request.response.add(UTF8.encode(JSON.encode({
        'status': e.statusCode,
        'value': {'message': e.message}
      })));
    } catch (e) {
      request.response.add(UTF8.encode(JSON.encode({
        'status': 13,
        'value': {'message': e.toString()}
      })));
    } finally {
      await request.response.close();
    }
  }

  Future<dynamic> _forward(String method, String endpoint,
      [Map<String, dynamic> params]) async {
    List<String> endpointTokens = path.split(endpoint);
    if (endpointTokens.isEmpty) {
      endpointTokens = [''];
    }
    switch (endpointTokens[0]) {
      case 'enabledeep':
        // turn on Shadow DOM support, don't forward
        useDeep = true;
        return null;
      case 'disabledeep':
        // turn off Shadow DOM support, don't forward
        useDeep = false;
        return null;
      case 'screenshot':
        if (method == 'POST') {
          // take a screenshot and save to file system
          var file = new File(path.join(outputDir.path, params['file']));
          await file.writeAsBytes(await driver.captureScreenshotAsList());
          return null;
        }
        break;
      case 'source':
        if (method == 'POST') {
          // grab page source and save to file system
          await new File(path.join(outputDir.path, params['file']))
              .writeAsString(await driver.pageSource);
          return null;
        }
        break;
      case 'element':
        // process endpoints of the form /element/[id]/...
        if (endpointTokens.length >= 2) {
          endpointTokens[1] = await _findElement(endpointTokens[1]);
        }
        // process endpoint /element/[id]/equals/[id]
        if (endpointTokens.length == 4 && endpointTokens[2] == 'equals') {
          endpointTokens[3] = await _findElement(endpointTokens[3]);
        }
        break;
      case 'touch':
      case 'moveto':
        // several /touch/... endpoints and the /moveto endpoint have an
        // optional 'element' param with a WebElement id value
        if (params['element'] != null) {
          params = new Map.from(params);
          params['element'] = await _findElement(params['element']);
        }
        break;
      case 'execute':
      case 'execute_async':
        // /execute and /execute_async allow arbitrary JSON objects with
        // embedded WebElememt ids.
        params = await _deepCopy(params) as Map<String, dynamic>;
        break;
    }

    switch (method) {
      case 'GET':
        return await driver.getRequest(path.joinAll(endpointTokens));
      case 'DELETE':
        return await driver.deleteRequest(path.joinAll(endpointTokens));
      case 'POST':
        return await driver.postRequest(path.joinAll(endpointTokens), params);
      default:
        throw 'unsupported method $method';
    }
  }

  Future<String> _findElement(String id) async {
    var selector = "[$wdElementIdAttribute='$id']";
    if (useDeep) {
      selector = '* /deep/ $selector';
    }
    var elements =
        await driver.findElements(new By.cssSelector(selector)).toList();
    return elements.single.id;
  }

  dynamic _deepCopy(dynamic source) async {
    if (source is Map) {
      var copy = {};

      for (var key in source.keys) {
        var value = source[key];
        if (key == 'ELEMENT') {
          copy['ELEMENT'] = await _findElement(value);
        } else {
          copy[await _deepCopy(key)] = await _deepCopy(value);
        }
      }
      return copy;
    } else if (source is Iterable) {
      var copy = [];
      for (var value in source) {
        copy.add(await _deepCopy(value));
      }
      return copy;
    } else {
      return source;
    }
  }
}
