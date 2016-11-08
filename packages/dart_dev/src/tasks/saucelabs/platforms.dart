/// A utility class for representing and displaying Sauce Labs platform configurations,
/// as well as constants for commonly-used platforms.
library dart_dev.src.tasks.saucelabs.platforms;

import 'package:webdriver/io.dart' show Browser, BrowserPlatform, Capabilities;

/// A platform on which Sauce Labs tests will run, consisting of a browser,
/// an optional browser version, and an optional operating system.
class SaucePlatform {
  final String browser;
  final String browserVersion;
  final String os;

  const SaucePlatform(this.browser, {this.browserVersion: '', this.os: ''});

  /// Creates a new platform from its JSON representation.
  ///
  /// See <https://wiki.saucelabs.com/display/DOCS/JavaScript+Unit+Testing+Methods#JavaScriptUnitTestingMethods-StartJSUnitTests>.
  SaucePlatform.fromJson(List platformJson)
      : this(platformJson[1],
            browserVersion: platformJson[2], os: platformJson[0]);

  /// Returns the JSON representation of this platform, as expected by the Sauce Labs API.
  ///
  /// See <https://wiki.saucelabs.com/display/DOCS/JavaScript+Unit+Testing+Methods#JavaScriptUnitTestingMethods-StartJSUnitTests>.
  List<String> toJson() => [os, browser, browserVersion];

  /// Returns this platform represented as a map pf WebDriver `desiredCapabilities` key-value pairs.
  Map<String, String> asCapabilities() {
    return {
      Capabilities.browserName: browser,
      Capabilities.version: browserVersion,
      Capabilities.platform: os != '' ? os : BrowserPlatform.any,
    };
  }

  /// Returns a human-readable representation of this platform.
  ///
  /// __Example:__
  ///
  ///     print(chrome.toJson)         // [googlechrome, , ]
  ///     print(chrome)                // Chrome
  ///
  ///     print(firefoxOsx.toJson())   // [firefox, , mac]
  ///     print(firefoxOsx)            // Firefox on OS X
  ///
  ///     print(ie11.toJson())         // [internet explorer, 11, ]
  ///     print(ie11)                  // IE 11
  @override
  String toString() {
    var str = '';

    var os = _getFriendlyName(this.os);
    var browser = _getFriendlyName(this.browser);
    var version = _getFriendlyName(this.browserVersion);

    if (browser == '') {
      return os;
    } else {
      str += browser;
      if (version != '') {
        str += ' $version';
      }
      if (os != '') {
        str += ' on $os';
      }
    }

    return str;
  }

  static const Map<String, String> _friendlyNames = const <String, String>{
    // operating systems
    'mac': 'OS X',
    'windows': 'Windows',
    'linux': 'Linux',
    // browsers
    'safari': 'Safari',
    'firefox': 'Firefox',
    'googlechrome': 'Chrome',
    'chrome': 'Chrome',
    'internet explorer': 'IE',
  };

  static String _getFriendlyName(String string) {
    return _friendlyNames[string.toLowerCase()] ?? string;
  }
}

// ----------------------------------------------------------------
// Platform constants, for convenience.
// ----------------------------------------------------------------

const _osOsx = 'mac';
const _osWindows = 'Windows';

/// Chrome (OS and version agnostic).
const SaucePlatform chrome = const SaucePlatform(Browser.chrome);

/// Chrome on Windows (version agnostic).
const SaucePlatform chromeWindows =
    const SaucePlatform(Browser.chrome, os: _osWindows);

/// Chrome on OS X (version agnostic).
const SaucePlatform chromeOsx = const SaucePlatform(Browser.chrome, os: _osOsx);

/// Firefox on Windows (version agnostic).
const SaucePlatform firefoxWindows =
    const SaucePlatform(Browser.firefox, os: _osWindows);

/// Firefox on OS X (version agnostic).
const SaucePlatform firefoxOsx =
    const SaucePlatform(Browser.firefox, os: _osOsx);

/// Safari (OS and version agnostic).
const SaucePlatform safari = const SaucePlatform(Browser.safari, os: _osOsx);

/// Internet Explorer 10 (OS agnostic).
const SaucePlatform ie10 =
    const SaucePlatform(Browser.ie, browserVersion: '10');

/// Internet Explorer 11 (OS agnostic).
const SaucePlatform ie11 =
    const SaucePlatform(Browser.ie, browserVersion: '11');
