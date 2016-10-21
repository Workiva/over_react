library browser_detect;

import 'dart:html';
import 'dart:math';

part "src/browser.dart";
part "src/browser_version.dart";

final Browser browser = _determineBrowser();

Browser _determineBrowser() {
  return _browsers.firstWhere((browser) => browser.isCurrent, orElse: () => _unknown);
}

Iterable<Browser> _browsers = [_chrome, _safari, _opera, _ie, _firefox];

Browser _chrome = new Browser("Chrome",
    [() => _matchVendor("Google")],
    [() => new RegExp(r"Chrome/(.*)\s").firstMatch(window.navigator.appVersion)]);

Browser _safari = new Browser("Safari",
    [() => _matchVendor("Apple")],
    [() => new RegExp(r"Version/(.*)\s").firstMatch(window.navigator.appVersion)]);

Browser _opera = new Browser("Opera",
    [() => _matchVendor("Opera")],
    [() => new RegExp(r"OPR/(.*)\s").firstMatch(window.navigator.appVersion)]);

Browser _ie = new Browser("IE",
    [() => window.navigator.appName.contains("Microsoft"),
     () => window.navigator.appVersion.contains("Trident"),
     () => window.navigator.appVersion.contains("Edge")],
    [() => new RegExp(r"MSIE (.+?);").firstMatch(window.navigator.appVersion),
     () => new RegExp(r"rv:(.*)\)").firstMatch(window.navigator.appVersion),
     () => new RegExp(r"Edge/(.*)$").firstMatch(window.navigator.appVersion)]);

Browser _firefox = new Browser("Firefox",
    [() => window.navigator.userAgent.contains("Firefox")],
    [() => new RegExp(r"rv:(.*)\)").firstMatch(window.navigator.userAgent)]);

Browser _unknown = new _UnknownBrowser();

bool _matchVendor(String name) {
  var vendor = window.navigator.vendor;
  return vendor != null && vendor.contains(name);
}
