import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'type_parameters.over_react.g.dart';

// Test that the generated mixins have the correct generic params

mixin NoneProps on UiProps {}

mixin SingleProps<T> on UiProps {
  T single;
}

mixin SingleThatWontBeSpecifiedProps<T> on UiProps {
  T singleThatWontBeSpecified;
}

mixin SingleWithBoundProps<S extends Pattern> on UiProps {
  S singleWithBound;
}

mixin DoubleProps<A, B> on UiProps {
  A doubleA;
  B doubleB;
}

// Test that the generated class impl has the correct generic params
// and passes the specified generic params to uses the mixins correctly.

UiFactory<ConcreteNoneProps> ConcreteNone = _$ConcreteNone; // ignore: undefined_identifier
class ConcreteNoneProps = UiProps
    with
        NoneProps,
        SingleProps<String>,
        SingleThatWontBeSpecifiedProps,
        SingleWithBoundProps<RegExp>,
        DoubleProps<double, int>;

// Test that the generated class impl works when passing its generic params to mixins.

UiFactory<ConcreteArgsProps> ConcreteArgs = _$ConcreteArgs; // ignore: undefined_identifier
class ConcreteArgsProps<U, V extends Iterable> = UiProps
    with
        NoneProps,
        SingleProps<String>,
        SingleThatWontBeSpecifiedProps,
        SingleWithBoundProps<RegExp>,
        // Test forwarding generic params to mixins
        DoubleProps<U, V>;
