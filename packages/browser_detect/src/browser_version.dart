part of browser_detect;

class BrowserVersion implements Comparable<BrowserVersion> {
  final String value;

  bool get isUnknown => value == null || value.isEmpty;

  Iterable<int> _elements;
  Iterable<int> get elements {
    if (_elements == null) {
      _elements = value.split(".").map((value) => int.parse(value, onError: (_) => 0));
    }
    return _elements;
  }

  BrowserVersion(this.value);

  int compareTo(BrowserVersion other) {
    for (var i = 0; i < max(elements.length, other.elements.length); i++) {
      var value1 = i < elements.length ? elements.elementAt(i) : 0;
      var value2 = i < other.elements.length ? other.elements.elementAt(i) : 0;
      var result = Comparable.compare(value1, value2);

      if (result != 0) {
        return result;
      }
    }
    return 0;
  }

  bool operator >(other) {
    other = other is String ? new BrowserVersion(other) : other;
    return other is BrowserVersion ? compareTo(other) > 0 : false;
  }

  bool operator >=(other) {
    other = other is String ? new BrowserVersion(other) : other;
    return other is BrowserVersion ? compareTo(other) >= 0 : false;
  }

  bool operator <(other) {
    other = other is String ? new BrowserVersion(other) : other;
    return other is BrowserVersion ? compareTo(other) < 0 : false;
  }

  bool operator <=(other) {
    other = other is String ? new BrowserVersion(other) : other;
    return other is BrowserVersion ? compareTo(other) <= 0 : false;
  }

  bool operator ==(other) {
    other = other is String ? new BrowserVersion(other) : other;
    return other is BrowserVersion ? compareTo(other) == 0 : false;
  }

  int get hashCode => value.hashCode;

  String toString() => value;
}