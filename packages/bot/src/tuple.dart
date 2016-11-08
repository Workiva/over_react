library bot.tuple;

import 'util.dart';

class Tuple3<T1, T2, T3> extends Tuple<T1, T2> {
  final T3 item3;

  const Tuple3(T1 param1, T2 param2, this.item3) : super(param1, param2);

  bool operator ==(other) {
    return other is Tuple3 &&
        item1 == other.item1 &&
        item2 == other.item2 &&
        item3 == other.item3;
  }

  String toString() => "{item1: $item1, item2: $item2, item3: $item3}";

  int get hashCode => Util.getHashCode([item1, item2, item3]);
}

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  const Tuple(this.item1, this.item2);

  bool operator ==(other) {
    return other is Tuple && item1 == other.item1 && item2 == other.item2;
  }

  String toString() => "{item1: $item1, item2: $item2}";

  int get hashCode => Util.getHashCode([item1, item2]);

  dynamic toJson() => {'item1': item1, 'item2': item2};
}
