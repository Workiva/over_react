part of sass.transformer;

class TransformerOptions {
  final String executable;
  final String style;
  final bool compass;
  final bool lineNumbers;
  final bool copySources;

  TransformerOptions({String this.executable, String this.style, bool this.compass, bool this.lineNumbers, bool this.copySources});

  factory TransformerOptions.parse(Map configuration) {
    config(key, defaultValue) {
      var value = configuration[key];
      return value != null ? value : defaultValue;
    }

    return new TransformerOptions(
        executable: config("executable", Sass.defaultExecutable),
        style: config("style", null),
        compass: config("compass", false),
        lineNumbers: config("line-numbers", false),
        copySources: config("copy-sources", false));
  }
}

