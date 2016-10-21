part of bot.math;

class AffineTransform {
  num _scX, _shY, _shX, _scY, _tX, _tY;

  AffineTransform([num scaleX = 1, num shearY = 0,
      num shearX = 0, num scaleY = 1,
      num translateX = 0, num translateY = 0]) :
        _scX = scaleX, _scY = scaleY,
        _tX = translateX, _tY = translateY,
        _shX = shearX, _shY = shearY;

  factory AffineTransform.fromRotate(num theta, num x, num y) {
    return new AffineTransform().setToRotation(theta, x, y);
  }

  factory AffineTransform.fromScale(sx, sy) {
    return new AffineTransform(sx, 0, 0, sy, 0, 0);
  }

  factory AffineTransform.fromTranslat(num x, num y) {
    return new AffineTransform(1, 0, 0, 1, x, y);
  }

  num get scaleX => _scX;

  num get scaleY => _scY;

  num get translateX => _tX;

  num get translateY => _tY;

  Vector get translateVector => new Vector(translateX, translateY);

  num get shearX => _shX;

  num get shearY => _shY;

  num get determinant => _scX * _scY - _shX * _shY;

  AffineTransform updateValues({num translateX: null, num translateY: null,
    num scaleX: null, num scaleY: null, num shearX: null, num shearY: null}) {
    if(translateX != null) {
      _tX = translateX;
    }

    if (translateY != null) {
      _tY = translateY;
    }

    if (scaleX != null) {
      _scX = scaleX;
    }

    if (scaleY != null) {
      _scY = scaleY;
    }

    if (shearX != null) {
      _shX = shearX;
    }

    if (shearY != null) {
      _shY = shearY;
    }

    return this;
  }

  bool get isIdentity {
    return _scX == 1 && _shY == 0 &&
        _shX == 0 && _scY == 1 &&
        _tX == 0 && _tY == 0;
  }

  AffineTransform scale(num sx, num sy) {
    _scX *= sx;
    _shY *= sx;
    _shX *= sy;
    _scY *= sy;
    return this;
  }

  AffineTransform concatenate(tx) {
    var m0 = this._scX;
    var m1 = this._shX;
    this._scX = tx._scX * m0 + tx._shY * m1;
    this._shX = tx._shX * m0 + tx._scY * m1;
    this._tX += tx._tX * m0 + tx._tY * m1;

    m0 = this._shY;
    m1 = this._scY;
    this._shY = tx._scX * m0 + tx._shY * m1;
    this._scY = tx._shX * m0 + tx._scY * m1;
    this._tY += tx._tX * m0 + tx._tY * m1;
    return this;
  }

  AffineTransform rotate(num theta, num x, num y) {
    return this.concatenate(new AffineTransform.fromRotate(theta, x, y));
  }

  AffineTransform translate(num dx, num dy) {
    _tX += dx * _scX + dy * _shX;
    _tY += dx * _shY + dy * _scY;
    return this;
  }

  AffineTransform setToScale(sx, sy) {
    return setTransform(sx, 0, 0, sy, 0, 0);
  }

  AffineTransform setToRotation(num theta, num x, num y) {
    var cos = math.cos(theta);
    var sin = math.sin(theta);
    return this.setTransform(cos, sin, -sin, cos,
      x - x * cos + y * sin, y - x * sin - y * cos);
  }

  AffineTransform setToTranslation(num dx, num dy) {
    return setTransform(1, 0, 0, 1, dx, dy);
  }

  AffineTransform setFromTransfrom(AffineTransform tx) {
    requireArgumentNotNull(tx, 'tx');
    return setTransform(tx._scX, tx._shY,
      tx._shX, tx._scY,
      tx._tX, tx._tY);
  }

  AffineTransform setTransform (num m00, num m10, num m01,
    num m11, num m02, num m12) {
    this._scX = m00;
    this._shY = m10;
    this._shX = m01;
    this._scY = m11;
    this._tX = m02;
    this._tY = m12;
    return this;
  }

  Coordinate transformCoordinate([math.Point point = const Coordinate()]) {
    num x = point.x * _scX + point.y * _shX + _tX;
    num y = point.x * _shY + point.y * _scY + _tY;

    return new Coordinate(x, y);
  }

  AffineTransform createInverse() {
    num det = determinant;
    return new AffineTransform(
        _scY / det,
        -_shY / det,
        -_shX / det,
        _scX / det,
        (_shX * _tY - _scY * _tX) / det,
        (_shY * _tX - _scX * _tY) / det);
  }

  AffineTransform lerpTx(AffineTransform other, num x) {
    requireArgumentNotNull(other, 'other');

    final m00 = lerp(scaleX, other.scaleX, x);
    final m10 = lerp(shearY, other.shearY, x);
    final m01 = lerp(shearX, other.shearX, x);
    final m11 = lerp(scaleY, other.scaleY, x);
    final m02 = lerp(translateX, other.translateX, x);
    final m12 = lerp(translateY, other.translateY, x);

    return new AffineTransform(m00, m10, m01, m11, m02, m12);
  }

  AffineTransform clone() {
    return new AffineTransform(_scX, _shY, _shX, _scY, _tX, _tY);
  }

  bool operator ==(other) {
    return other is AffineTransform &&
        _scX == other._scX && _shX == other._shX && _tX == other._tX &&
        _shY == other._shY && _scY == other._scY && _tY == other._tY;
  }

  // NOTE: AffineTransform is mutable and also implements ==
  // returning a 0 from hashCode ensures instances don't get lost in hash
  // implementations. These really shouldn't be used for keys anyway.
  int get hashCode => 0;

  String toString() =>
    [scaleX, shearY, shearX, scaleY, translateX, translateY].join(', ');
}
