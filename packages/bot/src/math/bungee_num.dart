part of bot.math;

// TODO: test!
class BungeeNum {
  num _target;
  num _current;
  num _velocity;

  BungeeNum(num target, [num current]) {
    this.target = target;
    if (current == null) {
      current = target;
    }
    this.current = current;
  }

  num get target => _target;

  void set target(num value) {
    requireArgument(isValidNumber(value), 'value');
    _target = value;
  }

  num get current => _current;

  void set current(num value) {
    requireArgument(isValidNumber(value), 'value');
    _current = value;
  }

  bool update() {
    assert(isValidNumber(_target));
    assert(isValidNumber(_current));

    if (_velocity == null) {
      _velocity = 0;
    } else {
      _velocity *= 0.8;
    }
    assert(isValidNumber(_velocity));

    final force = _target - _current;

    _velocity += (force * 0.05);

    _current += _velocity;

    final delta = (_current - _target).abs();

    if (delta < 0.01 && _velocity.abs() < 0.01) {
      _current = _target;
      _velocity = null;
      return false;
    } else {
      return true;
    }
  }
}
