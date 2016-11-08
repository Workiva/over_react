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

library webdriver.io;

import 'dart:async' show Future;
import 'dart:convert' show JSON, UTF8;
import 'dart:io'
    show
        ContentType,
        HttpClient,
        HttpClientRequest,
        HttpClientResponse,
        HttpHeaders;

import 'package:webdriver/support/async.dart' show Lock;
import 'package:webdriver/core.dart' as core
    show createDriver, fromExistingSession, WebDriver;
import 'package:webdriver/src/command_processor.dart' show CommandProcessor;
import 'package:webdriver/src/exception.dart' show WebDriverException;

export 'package:webdriver/core.dart' hide createDriver, fromExistingSession;

/// Creates a WebDriver instance connected to the specified WebDriver server.
///
/// Note: WebDriver endpoints will be constructed using [resolve] against
/// [uri]. Therefore, if [uri] does not end with a trailing slash, the
/// last path component will be dropped.
Future<core.WebDriver> createDriver({Uri uri, Map<String, dynamic> desired}) =>
    core.createDriver(new IOCommandProcessor(), uri: uri, desired: desired);

/// Creates a WebDriver instance connected to an existing session.
///
/// Note: WebDriver endpoints will be constructed using [resolve] against
/// [uri]. Therefore, if [uri] does not end with a trailing slash, the
/// last path component will be dropped.
Future<core.WebDriver> fromExistingSession(String sessionId, {Uri uri}) =>
    core.fromExistingSession(new IOCommandProcessor(), sessionId, uri: uri);

final ContentType _contentTypeJson =
    new ContentType("application", "json", charset: "utf-8");

class IOCommandProcessor implements CommandProcessor {
  final HttpClient client = new HttpClient();

  final Lock _lock = new Lock();

  @override
  Future<dynamic> post(Uri uri, dynamic params, {bool value: true}) async {
    await _lock.acquire();
    HttpClientRequest request = await client.postUrl(uri);
    _setUpRequest(request);
    request.headers.contentType = _contentTypeJson;
    if (params != null) {
      var body = UTF8.encode(JSON.encode(params));
      request.contentLength = body.length;
      request.add(body);
    } else {
      request.contentLength = 0;
    }
    return await _processResponse(await request.close(), value);
  }

  @override
  Future<dynamic> get(Uri uri, {bool value: true}) async {
    await _lock.acquire();
    HttpClientRequest request = await client.getUrl(uri);
    _setUpRequest(request);
    return await _processResponse(await request.close(), value);
  }

  @override
  Future<dynamic> delete(Uri uri, {bool value: true}) async {
    await _lock.acquire();
    HttpClientRequest request = await client.deleteUrl(uri);
    _setUpRequest(request);
    return await _processResponse(await request.close(), value);
  }

  @override
  Future close() async {
    await client.close(force: true);
  }

  _processResponse(HttpClientResponse response, bool value) async {
    var respDecoded = await UTF8.decodeStream(response);
    _lock.release();
    Map respBody;
    try {
      respBody = JSON.decode(respDecoded);
    } catch (e) {}

    if (response.statusCode < 200 ||
        response.statusCode > 299 ||
        (respBody is Map && respBody['status'] != 0)) {
      throw new WebDriverException(
          httpStatusCode: response.statusCode,
          httpReasonPhrase: response.reasonPhrase,
          jsonResp: respBody);
    }
    if (value && respBody is Map) {
      return respBody['value'];
    }
    return respBody;
  }

  void _setUpRequest(HttpClientRequest request) {
    request.followRedirects = true;
    request.headers.add(HttpHeaders.ACCEPT, "application/json");
    request.headers.add(HttpHeaders.ACCEPT_CHARSET, UTF8.name);
    request.headers.add(HttpHeaders.CACHE_CONTROL, "no-cache");
  }
}
