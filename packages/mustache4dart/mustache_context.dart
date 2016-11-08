library mustache_context;

import 'dart:collection';

@MirrorsUsed(symbols: '*')
import 'dart:mirrors';

const USE_MIRRORS = const bool.fromEnvironment('MIRRORS', defaultValue: true);
const String DOT = '\.';

typedef NoParamLambda();
typedef OptionalParamLambda({nestedContext});
typedef TwoParamLambda(String s, {nestedContext});

abstract class MustacheContext {

  factory MustacheContext(ctx, {MustacheContext parent,
      assumeNullNonExistingProperty: true}) {
    if (ctx is Iterable) {
      return new _IterableMustacheContextDecorator(
          ctx,
          parent: parent,
          assumeNullNonExistingProperty: assumeNullNonExistingProperty);
    }
    return new _MustacheContext(
        ctx,
        parent: parent,
        assumeNullNonExistingProperty: assumeNullNonExistingProperty);
  }

  call([arg]);

  bool get isFalsey;
  bool get isLambda;
  MustacheContext operator [](String key);
  MustacheContext _getMustachContext (String key);
  String get rootContextString;
  
}

abstract class MustacheToString {
  dynamic get ctx;
  MustacheContext get parent;

  String get rootContextString =>
      parent == null ? ctx.toString() : parent.rootContextString;
}

class _MustacheContext extends MustacheToString implements MustacheContext {
  static final FALSEY_CONTEXT = new _MustacheContext(false);
  final ctx;
  final _MustacheContext parent;
  final bool assumeNullNonExistingProperty;
  bool useMirrors = USE_MIRRORS;
  _ObjectReflector _ctxReflector;

  _MustacheContext(this.ctx, {_MustacheContext this.parent,
      this.assumeNullNonExistingProperty});

  bool get isLambda => ctx is Function;

  bool get isFalsey => ctx == null || ctx == false;

  call([arg]) => isLambda ? callLambda(arg) : ctx.toString();

  callLambda(arg) =>
      ctx is NoParamLambda ?
          ctx() :
          ctx is TwoParamLambda ?
              ctx(arg, nestedContext: this) :
              ctx is OptionalParamLambda ? ctx(nestedContext: this) : ctx(arg);

  operator [](String key) {
    if (ctx == null) return null;
    return _getInThisOrParent(key);
  }

  _getInThisOrParent(String key) {
    var result = _getContextForKey(key);
    //if the result is null, try the parent context
    if (result == null && !_hasActualValueSlot(key) && parent != null) {
      result = parent[key];
      if (result != null) {
        return _newMustachContextOrNull(result.ctx);
      }
    }
    return result;
  }

  _getContextForKey(String key) {
    if (key == DOT) {
      return this;
    }
    if (key.contains(DOT)) {
      Iterator<String> i = key.split(DOT).iterator;
      var val = this;
      while (i.moveNext()) {
        val = val._getMustachContext(i.current);
        if (val == null) {
          return null;
        }
      }
      return val;
    }
    //else
    return _getMustachContext(key);
  }

  _getMustachContext(String key) {
    var v = _getActualValue(key);
    return _newMustachContextOrNull(v);
  }

  _newMustachContextOrNull(v) {
    if (v == null) {
      return null;
    }
    if (v is Iterable) {
      return new _IterableMustacheContextDecorator(
          v,
          parent: this,
          assumeNullNonExistingProperty: this.assumeNullNonExistingProperty);
    }
    if (v == false) {
      return FALSEY_CONTEXT;
    }
    return new _MustacheContext(
        v,
        parent: this,
        assumeNullNonExistingProperty: assumeNullNonExistingProperty);
  }

  dynamic _getActualValue(String key) {
    try {
      return ctx[key];
    } catch (NoSuchMethodError) {
      //Try to make dart2js understand that when we define USE_MIRRORS = false
      //we do not want to use any reflector
      return (useMirrors && USE_MIRRORS) ? ctxReflector[key] : null;
    }
  }

  bool _hasActualValueSlot(String key) {
    if (assumeNullNonExistingProperty) {
      return false;
    }
    if (ctx is Map) {
      return (ctx as Map).containsKey(key);
    } else if (useMirrors && USE_MIRRORS) {
      //TODO test the case of no mirrors
      return ctxReflector.hasSlot(key);
    }
    return false;
  }

  get ctxReflector {
    if (_ctxReflector == null) {
      _ctxReflector = new _ObjectReflector(ctx);
    }
    return _ctxReflector;
  }

  String toString() => "MustacheContext($ctx, $parent)";
}

class _IterableMustacheContextDecorator extends IterableBase<_MustacheContext>
    with MustacheToString implements MustacheContext {
  final Iterable ctx;
  final _MustacheContext parent;
  final bool assumeNullNonExistingProperty;

  _IterableMustacheContextDecorator(this.ctx, {this.parent,
      this.assumeNullNonExistingProperty});

  call([arg]) => throw new Exception('Iterable can be called as a function');

  Iterator<_MustacheContext> get iterator =>
      new _MustachContextIteratorDecorator(
          ctx.iterator,
          parent: parent,
          assumeNullNonExistingProperty: assumeNullNonExistingProperty);

  int get length => ctx.length;

  bool get isEmpty => ctx.isEmpty;

  bool get isFalsey => isEmpty;

  bool get isLambda => false;

  operator [](String key) {
    if (key == DOT) {
      return this;
    }
    throw new Exception(
        'Iterable can only be iterated. No [] implementation is available');
  }
  
  _getMustachContext (String key) {
    if (key == 'empty' || key == 'isEmpty') {
      return new _MustacheContext(isEmpty, parent: parent, assumeNullNonExistingProperty: assumeNullNonExistingProperty);
    }
    throw new Exception(
            'Iterable can only be asked for empty or isEmpty keys or be iterated');
  }
}



class _MustachContextIteratorDecorator extends Iterator<_MustacheContext> {
  final Iterator delegate;
  final _MustacheContext parent;
  final bool assumeNullNonExistingProperty;

  _MustacheContext current;

  _MustachContextIteratorDecorator(this.delegate, {this.parent,
      this.assumeNullNonExistingProperty});

  bool moveNext() {
    if (delegate.moveNext()) {
      current = new _MustacheContext(
          delegate.current,
          parent: parent,
          assumeNullNonExistingProperty: assumeNullNonExistingProperty);
      return true;
    } else {
      current = null;
      return false;
    }
  }
}

/**
 * Helper class which given an object it will try to get a value by key analyzing
 * the object by reflection
 */
class _ObjectReflector {
  final InstanceMirror m;

  factory _ObjectReflector(o) {
    return new _ObjectReflector._(reflect(o));
  }

  _ObjectReflector._(this.m);

  operator [](String key) {
    var declaration = getDeclaration(key);

    if (declaration == null) {
      return null;
    }

    return declaration.value;
  }

  bool hasSlot(String key) {
    return getDeclaration(key) != null;
  }

  _ObjectReflectorDeclaration getDeclaration(String key) {
    return new _ObjectReflectorDeclaration(m, key);
  }
}

class _ObjectReflectorDeclaration {
  final InstanceMirror mirror;
  final MethodMirror declaration;

  factory _ObjectReflectorDeclaration(InstanceMirror m, String declarationName)
      {
    var methodMirror = m.type.instanceMembers[new Symbol(declarationName)];
    if (methodMirror == null) {
      //try appending the word get to the name:
      var nameWithGet =
          "get${declarationName[0].toUpperCase()}${declarationName.substring(1)}";
      methodMirror = m.type.instanceMembers[new Symbol(nameWithGet)];
    }
    return methodMirror == null ?
        null :
        new _ObjectReflectorDeclaration._(m, methodMirror);
  }

  _ObjectReflectorDeclaration._(this.mirror, this.declaration);

  bool get isLambda => declaration.parameters.length >= 1;

  Function get lambda => (val, {MustacheContext nestedContext}) {
    var im = mirror.invoke(
        declaration.simpleName,
        _createPositionalArguments(val),
        _createNamedArguments(nestedContext));
    return im is InstanceMirror ? im.reflectee : null;
  };

  _createPositionalArguments(val) {
    var positionalParam =
        declaration.parameters.firstWhere((p) => !p.isOptional, orElse: () => null);
    if (positionalParam == null) {
      return [];
    } else {
      return [val];
    }
  }

  _createNamedArguments(MustacheContext ctx) {
    var map = {};
    var nestedContextParameterExists = declaration.parameters.firstWhere(
        (p) => p.simpleName == new Symbol('nestedContext'),
        orElse: () => null);
    if (nestedContextParameterExists != null) {
      map[nestedContextParameterExists.simpleName] = ctx;
    }
    return map;
  }

  get value {
    if (isLambda) {
      return lambda;
    }

    //Now we try to find out a field or a getter named after the given name
    var im = null;
    if (isVariableOrGetter) {
      im = mirror.getField(declaration.simpleName);
    } else if (isParameterlessMethod) {
      im = mirror.invoke(declaration.simpleName, []);
    }
    if (im != null && im is InstanceMirror) {
      return im.reflectee;
    }
    return null;
  }

  //TODO check if we really need the declaration is VariableMirror test
  bool get isVariableOrGetter =>
      (declaration is VariableMirror) ||
          (declaration is MethodMirror && declaration.isGetter);

  bool get isParameterlessMethod =>
      declaration is MethodMirror && declaration.parameters.length == 0;
}
