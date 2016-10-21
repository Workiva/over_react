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

part of webdriver.core;

/// Capabilities constants.
class Capabilities {
  static const String browserName = "browserName";
  static const String platform = "platform";
  static const String supportsJavascript = "javascriptEnabled";
  static const String takesScreenshot = "takesScreenshot";
  static const String version = "version";
  static const String supportsAlerts = "handlesAlerts";
  static const String supportSqlDatabase = "databaseEnabled";
  static const String supportsLocationContext = "locationContextEnabled";
  static const String supportsApplicationCache = "applicationCacheEnabled";
  static const String supportsBrowserConnection = "browserConnectionEnabled";
  static const String supportsFindingByCss = "cssSelectorsEnabled";
  static const String proxy = "proxy";
  static const String supportsWebStorage = "webStorageEnabled";
  static const String rotatable = "rotatable";
  static const String acceptSslCerts = "acceptSslCerts";
  static const String hasNativeEvents = "nativeEvents";
  static const String unexpectedAlertBehaviour = "unexpectedAlertBehaviour";
  static const String loggingPrefs = "loggingPrefs";
  static const String enableProfiling = "webdriver.logging.profiler.enabled";

  static Map<String, dynamic> get chrome => empty
    ..[browserName] = Browser.chrome
    ..[version] = ''
    ..[platform] = BrowserPlatform.any;

  static Map<String, dynamic> get firefox => empty
    ..[browserName] = Browser.firefox
    ..[version] = ''
    ..[platform] = BrowserPlatform.any;

  static Map<String, dynamic> get android => empty
    ..[browserName] = Browser.android
    ..[version] = ''
    ..[platform] = BrowserPlatform.android;

  static Map<String, dynamic> get empty => new Map<String, dynamic>();
}

/// Browser name constants.
class Browser {
  static const String firefox = "firefox";
  static const String safari = "safari";
  static const String opera = "opera";
  static const String chrome = "chrome";
  static const String android = "android";
  static const String ie = "internet explorer";
  static const String iphone = "iPhone";
  static const String ipad = "iPad";
}

/// Browser operating system constants.
class BrowserPlatform {
  static const String any = "ANY";
  static const String android = "ANDROID";
}
