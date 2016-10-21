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

library webdriver.html;

import 'dart:async' show Future;
import 'dart:convert' show JSON;
import 'dart:html' show HttpRequest, ProgressEvent;

import 'package:webdriver/support/async.dart' show Lock;
import 'package:webdriver/core.dart' as core
    show createDriver, fromExistingSession, WebDriver;
import 'package:webdriver/src/command_processor.dart' show CommandProcessor;
import 'package:webdriver/src/exception.dart' show WebDriverException;

export 'package:webdriver/core.dart' hide createDriver, fromExistingSession;

final Uri defaultUri = Uri.parse('http://127.0.0.1:4444/wd/hub/');

/// Creates a WebDriver instance connected to the specified WebDriver server.
///
/// Note: WebDriver endpoints will be constructed using [resolve] against
/// [uri]. Therefore, if [uri] does not end with a trailing slash, the
/// last path component will be dropped.
Future<core.WebDriver> createDriver({Uri uri, Map<String, dynamic> desired}) =>
    core.createDriver(new _HtmlCommandProcessor(), uri: uri, desired: desired);

/// Creates a WebDriver instance connected to an existing session.
///
/// Note: WebDriver endpoints will be constructed using [resolve] against
/// [uri]. Therefore, if [uri] does not end with a trailing slash, the
/// last path component will be dropped.
Future<core.WebDriver> fromExistingSession(String sessionId, {Uri uri}) =>
    core.fromExistingSession(new _HtmlCommandProcessor(), sessionId, uri: uri);

class _HtmlCommandProcessor implements CommandProcessor {
  final Lock _lock = new Lock();

  @override
  Future<dynamic> post(Uri uri, dynamic params, {bool value: true}) =>
      _request('POST', uri, params, value);

  @override
  Future<dynamic> get(Uri uri, {bool value: true}) =>
      _request('GET', uri, null, value);

  @override
  Future<dynamic> delete(Uri uri, {bool value: true}) =>
      _request('DELETE', uri, null, value);

  @override
  Future close() async {}

  Future<dynamic> _request(
      String method, Uri uri, dynamic params, bool value) async {
    await _lock.acquire();
    var sendData = null;
    if (params != null && method == 'POST') {
      sendData = JSON.encode(params);
    }

    HttpRequest request;
    try {
      request = await HttpRequest.request(uri.toString(),
          method: method,
          requestHeaders: _headers,
          responseType: 'json',
          sendData: sendData,
          mimeType: 'application/json');
    } on ProgressEvent catch (e) {
      request = e.target;
    } finally {
      _lock.release();
    }
    var respBody = request.response;
    try {
      respBody = JSON.decode(respBody);
    } catch (e) {}

    if (request.status < 200 ||
        request.status > 299 ||
        (respBody is Map && respBody['status'] != 0)) {
      throw new WebDriverException(
          httpStatusCode: request.status,
          httpReasonPhrase: request.statusText,
          jsonResp: respBody);
    }
    if (value && respBody is Map) {
      return respBody['value'];
    }
    return respBody;
  }

  Map<String, String> get _headers => {'Accept': 'application/json',};
}
