// Dummy annotations that would be used by Pub code generator
library web_skin_dart.transformer_generation.annotations;

class Factory {
  const Factory();
}

class Props {
  final String keyNamespace;
  const Props({String this.keyNamespace: null});
}

class State {
  final String keyNamespace;
  const State({String this.keyNamespace: null});
}

class Component {
  final bool isWrapper;
  const Component({bool this.isWrapper: false});
}


class AbstractProps {
  final String keyNamespace;
  const AbstractProps({String this.keyNamespace: null});
}

class AbstractState {
  final String keyNamespace;
  const AbstractState({String this.keyNamespace: null});
}

class AbstractComponent {
  const AbstractComponent();
}


class PropsMixin {
  final String keyNamespace;
  const PropsMixin({String this.keyNamespace: null});
}

class StateMixin {
  final String keyNamespace;
  const StateMixin({String this.keyNamespace: null});
}
