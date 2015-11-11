// Dummy annotations that would be used by Pub code generator
library web_skin_dart.transformer_generation.annotations;

class Factory {
  const Factory();
}

class Props implements TypedMap {
  final String keyNamespace;
  const Props({String this.keyNamespace: null});
}

class State implements TypedMap {
  final String keyNamespace;
  const State({String this.keyNamespace: null});
}

class Component {
  final bool isWrapper;
  const Component({bool this.isWrapper: false});
}


class AbstractProps implements TypedMap {
  final String keyNamespace;
  const AbstractProps({String this.keyNamespace: null});
}

class AbstractState implements TypedMap {
  final String keyNamespace;
  const AbstractState({String this.keyNamespace: null});
}

class AbstractComponent {
  const AbstractComponent();
}


class PropsMixin implements TypedMap {
  final String keyNamespace;
  const PropsMixin({String this.keyNamespace: null});
}

class StateMixin implements TypedMap {
  final String keyNamespace;
  const StateMixin({String this.keyNamespace: null});
}


class Accessor {
  final String key;
  final String keyNamespace;
  final bool abstract;

  const Accessor({
    String this.key: null,
    String this.keyNamespace: null,
    bool this.abstract: false
  });
}

abstract class TypedMap {
  String get keyNamespace;
}
