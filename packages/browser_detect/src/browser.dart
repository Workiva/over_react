part of browser_detect;

class Browser {
  final String name;

  bool get isChrome => this == _chrome;
  bool get isSafari => this == _safari;
  bool get isOpera => this == _opera;
  bool get isIe => this == _ie;
  bool get isFirefox => this == _firefox;
  bool get isCurrent => _vendorMatchers.any((matcher) => matcher());

  BrowserVersion _version;
  BrowserVersion get version {
    if (_version == null) {
      var value = _versionMatchers.map((matcher) => matcher())
          .firstWhere((match) => match != null)
          .group(1);
      _version = new BrowserVersion(value);
    }
    return _version;
  }

  final Iterable<_VendorMatcher> _vendorMatchers;
  final Iterable<_VersionMatcher> _versionMatchers;

  Browser(this.name, this._vendorMatchers, this._versionMatchers);

  String toString() => "$name $version".trim();
}

class _UnknownBrowser extends Browser {
  _UnknownBrowser() : super("Unknown Browser", [() => true], [() => ""]);
}

typedef bool _VendorMatcher();
typedef Match _VersionMatcher();