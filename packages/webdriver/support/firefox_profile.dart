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

library webdriver.support.firefox_profile;

import 'dart:collection';
import 'dart:convert' show LineSplitter, BASE64;
import 'dart:io' as io;
import 'package:archive/archive.dart' show Archive, ArchiveFile, ZipEncoder;
import 'package:path/path.dart' as path;

/// Unmodifiable defaults for 'prefs.js' and 'user.js'.
final List<PrefsOption> lockedPrefs = <PrefsOption>[
  new BooleanOption("app.update.auto", false),
  new BooleanOption("app.update.enabled", false),
  new IntegerOption("browser.displayedE10SNotice", 4),
  new BooleanOption("browser.download.manager.showWhenStarting", false),
  new BooleanOption("browser.EULA.override", true),
  new BooleanOption("browser.EULA.3.accepted", true),
  new IntegerOption("browser.link.open_external", 2),
  new IntegerOption("browser.link.open_newwindow", 2),
  new BooleanOption("browser.offline", false),
  new BooleanOption("browser.reader.detectedFirstArticle", true),
  new BooleanOption("browser.safebrowsing.enabled", false),
  new BooleanOption("browser.safebrowsing.malware.enabled", false),
  new BooleanOption("browser.search.update", false),
  new StringOption("browser.selfsupport.url", ""),
  new BooleanOption("browser.sessionstore.resume_from_crash", false),
  new BooleanOption("browser.shell.checkDefaultBrowser", false),
  new BooleanOption("browser.tabs.warnOnClose", false),
  new BooleanOption("browser.tabs.warnOnOpen", false),
  new BooleanOption("datareporting.healthreport.service.enabled", false),
  new BooleanOption("datareporting.healthreport.uploadEnabled", false),
  new BooleanOption("datareporting.healthreport.service.firstRun", false),
  new BooleanOption("datareporting.healthreport.logging.consoleEnabled", false),
  new BooleanOption("datareporting.policy.dataSubmissionEnabled", false),
  new BooleanOption("datareporting.policy.dataSubmissionPolicyAccepted", false),
  new BooleanOption("devtools.errorconsole.enabled", true),
  new BooleanOption("dom.disable_open_during_load", false),
  new IntegerOption("extensions.autoDisableScopes", 10),
  new BooleanOption("extensions.blocklist.enabled", false),
  new BooleanOption("extensions.logging.enabled", true),
  new BooleanOption("extensions.update.enabled", false),
  new BooleanOption("extensions.update.notifyUser", false),
  new BooleanOption("javascript.enabled", true),
  new BooleanOption("network.manage-offline-status", false),
  new IntegerOption("network.http.phishy-userpass-length", 255),
  new BooleanOption("offline-apps.allow_by_default", true),
  new BooleanOption("prompts.tab_modal.enabled", false),
  new BooleanOption("security.csp.enable", false),
  new IntegerOption("security.fileuri.origin_policy", 3),
  new BooleanOption("security.fileuri.strict_origin_policy", false),
  new BooleanOption("security.warn_entering_secure", false),
  new BooleanOption("security.warn_entering_secure.show_once", false),
  new BooleanOption("security.warn_entering_weak", false),
  new BooleanOption("security.warn_entering_weak.show_once", false),
  new BooleanOption("security.warn_leaving_secure", false),
  new BooleanOption("security.warn_leaving_secure.show_once", false),
  new BooleanOption("security.warn_submit_insecure", false),
  new BooleanOption("security.warn_viewing_mixed", false),
  new BooleanOption("security.warn_viewing_mixed.show_once", false),
  new BooleanOption("signon.rememberSignons", false),
  new BooleanOption("toolkit.networkmanager.disable", true),
  new IntegerOption("toolkit.telemetry.prompted", 2),
  new BooleanOption("toolkit.telemetry.enabled", false),
  new BooleanOption("toolkit.telemetry.rejected", true),
  new BooleanOption("xpinstall.signatures.required", false),
];

/// Default values for 'user.js'.
final List<PrefsOption> defaultUserPrefs = <PrefsOption>[
  new BooleanOption("browser.dom.window.dump.enabled", true),
  new StringOption("browser.newtab.url", "about:blank"),
  new BooleanOption("browser.newtabpage.enabled", false),
  new IntegerOption("browser.startup.page", 0),
  new StringOption("browser.startup.homepage", "about:blank"),
  new IntegerOption("dom.max_chrome_script_run_time", 30),
  new IntegerOption("dom.max_script_run_time", 30),
  new BooleanOption("dom.report_all_js_exceptions", true),
  new BooleanOption("javascript.options.showInConsole", true),
  new IntegerOption("network.http.max-connections-per-server", 10),
  new StringOption("startup.homepage_welcome_url", "about:blank"),
  new BooleanOption("webdriver_accept_untrusted_certs", true),
  new BooleanOption("webdriver_assume_untrusted_issuer", true),
];

/// Creates a Firefox profile in a format so it can be passed using the
/// `desired` capabilities map.
class FirefoxProfile {
  final io.Directory profileDirectory;

  Set<PrefsOption> _prefs = new Set<PrefsOption>();

  /// The read-only settings of the `prefs.js` file of the profile directory.
  List<PrefsOption> get prefs => new UnmodifiableListView<PrefsOption>(_prefs);

  /// The settings of the `user.js` file of the profile directory overridden by
  /// the settings in [lockedPrefs].
  /// [setOption] and [removeOption] allow to update, add, and remove settings
  /// except these included in [lockedPrefs].
  Set<PrefsOption> _userPrefs = new Set<PrefsOption>();
  List<PrefsOption> get userPrefs =>
      new UnmodifiableListView<PrefsOption>(_userPrefs);

  /// Creates a new FirefoxProfile.
  ///
  /// If [profileDirectory] is passed the files from this directory will be
  /// included in the output generated by [toJson].
  /// The files `prefs.js` and `user.js` are loaded from the directory if they
  /// exist and their settings are added to [prefs] and [userPrefs].
  /// Settings from [lockedPrefs] are also added to [prefs] and always take
  /// precedence and can not be overridden or removed.
  ///
  /// If [profileDirectory] is `null` the content returned by [toJson] only
  /// consists of [lockedPrefs] as `prefs.js` and [defaultUserPrefs] and the
  /// dynamic updates made with [setOption] and [removeOption] as `user.js`.
  FirefoxProfile({this.profileDirectory}) {
    _userPrefs.addAll(defaultUserPrefs);
    if (profileDirectory != null) {
      final prefsFile =
          new io.File(path.join(profileDirectory.absolute.path, 'prefs.js'));
      if (prefsFile.existsSync()) {
        _prefs = loadPrefsFile(prefsFile);
      }

      final userPrefsFile =
          new io.File(path.join(profileDirectory.absolute.path, 'user.js'));
      if (userPrefsFile.existsSync()) {
        _userPrefs = loadPrefsFile(userPrefsFile)
            .where((option) => !lockedPrefs.contains(option));
      }
    }
    _prefs.addAll(lockedPrefs);
  }

  /// Add an option or replace an option if one already exists with the same
  /// name.
  /// If option exists in [lockedPrefs] it will not be added.
  /// Returns `true` if [userPrefs] was updated, `false` otherwise.
  bool setOption(PrefsOption option) {
    if (lockedPrefs.contains(option)) {
      print('Option "${option.name}" (${option.value}) is locked and therefore '
          'ignored');
      return false;
    }
    _userPrefs.add(option);
    return true;
  }

  /// Remove the option named [name] from [userPrefs].
  /// If [lockedPrefs] contains this option it will not be removed.
  /// Returns `true` if [userPrefs] was removed, `false` if it was not removed
  /// because [userPrefs] doesn't contain it because [lockedPrefs]
  /// contains it.
  bool removeOption(String name) {
    final option = _userPrefs.firstWhere((o) => o.name == name,
        orElse: () => new InvalidOption(name));
    if (option is InvalidOption) {
      return false;
    }
    return _userPrefs.remove(option);
  }

  /// Helper for [loadPrefsFile]
  static bool _ignoreLine(String line) {
    line ??= '';
    line = line.trim();
    if (line.isEmpty ||
        line.startsWith('//') ||
        line.startsWith('#') ||
        line.startsWith('/*') ||
        line.startsWith('*') ||
        line.startsWith('*/')) {
      return true;
    }
    return false;
  }

  /// Load a prefs file and parse the content into a set of [PrefsOption].
  /// For lines which can't be properly parsed a message is printed and the line
  /// is otherwise ignored.
  /// Comments, lines starting with `//` are silently ignored.
  static Set<PrefsOption> loadPrefsFile(io.File file) {
    final prefs = new Set<PrefsOption>();
    final lines = LineSplitter
        .split(file.readAsStringSync())
        .where((line) => !_ignoreLine(line));
    bool canNotParseCaption = true;

    for (final line in lines) {
      final option = new PrefsOption.parse(line);
      if (option is InvalidOption) {
        if (canNotParseCaption) {
          print('Can\'t parse lines from file "${file.path}":');
          canNotParseCaption = false;
        }
        print('  ${line}');
        continue;
      }
      prefs.add(option);
    }
    return prefs;
  }

  /// Creates a map like `{'browserName: 'firefox', 'firefox_profile': 'xxxxx'}`
  /// where `xxxxx` is the zipped and base64 encoded content of the files in
  /// [profileDirectory] if one was pased.
  /// The files `prefs.js` and `user.js` are generated from the content of
  /// `prefs` and `userPrefs`.
  /// It can be uses like
  /// `var desired = Capabilities.firefox..addAll(firefoxProfile.toJson()}`
  Map toJson() {
    Archive archive = new Archive();
    if (profileDirectory != null) {
      profileDirectory.listSync(recursive: true).forEach((f) {
        ArchiveFile archiveFile;
        final name = path.relative(f.path, from: profileDirectory.path);
        if (f is io.Directory) {
          archiveFile = new ArchiveFile('${name}/', 0, []);
        } else if (f is io.File) {
          if (name == 'prefs.js' || name == 'user.js') {
            return;
          }
          archiveFile =
              new ArchiveFile(name, f.statSync().size, (f).readAsBytesSync());
        } else {
          throw 'Invalid file type for file "${f.path}" '
              '(${io.FileSystemEntity.typeSync(f.path)}).';
        }
        archive.addFile(archiveFile);
      });
    }
    final prefsJsContent =
        prefs.map((option) => option.asPrefString).join('\n').codeUnits;
    archive.addFile(
        new ArchiveFile('prefs.js', prefsJsContent.length, prefsJsContent));

    final userJsContent =
        userPrefs.map((option) => option.asPrefString).join('\n').codeUnits;
    archive.addFile(
        new ArchiveFile('user.js', userJsContent.length, userJsContent));

    final zipData = new ZipEncoder().encode(archive);
    return {'firefox_profile': BASE64.encode(zipData)};
  }
}

abstract class PrefsOption<T> {
  /// This pattern is used to parse preferences in user.js. It is intended to
  /// match all preference lines in the format generated by Firefox; it won't
  /// necessarily match all possible lines that Firefox will parse.
  ///
  /// e.g. if you have a line with extra spaces after the end-of-line semicolon,
  /// this pattern will not match that line because Firefox never generates
  /// lines like that.
  static final RegExp _preferencePattern =
      new RegExp(r'user_pref\("([^"]+)", ("?.+?"?)\);');

  final String name;
  T _value;
  dynamic get value => _value;

  factory PrefsOption(String name, value) {
    assert(value is bool || value is int || value is String);
    if (value is bool) {
      return new BooleanOption(name, value) as PrefsOption<T>;
    } else if (value is int) {
      return new IntegerOption(name, value) as PrefsOption<T>;
    } else if (value is String) {
      return new StringOption(name, value) as PrefsOption<T>;
    }
    return null;
  }

  factory PrefsOption.parse(String prefs) {
    final match = _preferencePattern.firstMatch(prefs);
    if (match == null) {
      return new InvalidOption('Not a valid prefs option: "${prefs}".')
          as PrefsOption<T>;
    }
    final name = match.group(1);
    final valueString = match.group(2);
    if (valueString.startsWith('"') && valueString.endsWith('"')) {
      final value = valueString
          .substring(1, valueString.length - 1)
          .replaceAll(r'\"', r'"')
          .replaceAll(r'\\', r'\');
      return new StringOption(name, value) as PrefsOption<T>;
    }
    if (valueString.toLowerCase() == 'true') {
      return new BooleanOption(name, true) as PrefsOption<T>;
    } else if (valueString.toLowerCase() == 'false') {
      return new BooleanOption(name, false) as PrefsOption<T>;
    }
    try {
      int value = int.parse(valueString);
      return new IntegerOption(name, value) as PrefsOption<T>;
    } catch (_) {}
    return new InvalidOption('Not a valid prefs option: "${prefs}".')
        as PrefsOption<T>;
  }

  PrefsOption._(this.name, [this._value]) {
    assert(name.isNotEmpty);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PrefsOption && this.name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  String get asPrefString => 'user_pref("${name}", ${_valueAsPrefString});';

  String get _valueAsPrefString;
}

/// Used as a placeholder for unparsable lines.
class InvalidOption extends PrefsOption<String> {
  InvalidOption(String value) : super._('invalid', value);

  @override
  String get _valueAsPrefString =>
      throw 'An invalid option can\'t be serialized.';
}

/// A boolean preferences option with name and value.
class BooleanOption extends PrefsOption<bool> {
  BooleanOption(String name, bool value) : super._(name, value);

  @override
  String get _valueAsPrefString => value.toString();
}

/// An integer preferences option with name and value.
class IntegerOption extends PrefsOption<int> {
  IntegerOption(String name, int value) : super._(name, value);

  @override
  String get _valueAsPrefString => value.toString();
}

/// A String preferences option with name and value.
/// [_valueAsPrefString] escapes `"` as `\"` and `\` as `\\`.
class StringOption extends PrefsOption<String> {
  StringOption(String name, String value) : super._(name, value);

  String _escape(String value) =>
      value.replaceAll(r'\', r'\\').replaceAll('"', r'\"');
  @override
  String get _valueAsPrefString {
    return '"${_escape(value)}"';
  }
}
