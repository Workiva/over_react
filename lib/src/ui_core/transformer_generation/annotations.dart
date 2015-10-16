// Dummy annotations that would be used by Pub code generator
library web_skin_dart.transformer_generation.annotations;

class $Factory {
  const $Factory();
}
class $Props {
  final bool mixin;
  final bool abstract;
  const $Props({this.mixin: false, this.abstract: false});
}
class $State {
  final bool mixin;
  final bool abstract;
  const $State({this.mixin: false, this.abstract: false});
}
class $Component {
  final bool abstract;
  const $Component({this.abstract: false});
}
const $Factory Factory = const $Factory();
const $Props Props = const $Props();
const $State State = const $State();
const $Component Component = const $Component();

const $Props AbstractProps = const $Props(abstract: true);
const $State AbstractState = const $State(abstract: true);
const $Component AbstractComponent = const $Component(abstract: true);

const $Props PropsMixin = const $Props(mixin: true);
const $State StateMixin = const $State(mixin: true);
