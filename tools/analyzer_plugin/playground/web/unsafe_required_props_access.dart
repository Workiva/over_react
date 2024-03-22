//@dart=2.12
import 'package:over_react/over_react.dart';

part 'unsafe_required_props_access.over_react.g.dart';

// debug:over_react_metrics


UiFactory<BarProps> Bar = castUiFactory(_$Bar); // ignore: undefined_identifier

mixin BarProps on UiProps {
  late String barRequired;
  late String? barRequiredNullable;
  late int barRequiredInt;

  String? notRequired;
}

class BarComponent extends UiComponent2<BarProps> {
  @override
  render() {
    print(props.barRequired);
    print(this.props.barRequired);
    return Dom.div()();
  }
}


foo(BarProps props, BarComponent component) {
  // Unsafe

  // Unsafe read
  print(props.barRequired);
  // Unsafe read, nested
  print(props.barRequired.toString());

  // Unsafe read via compound assignment
  props.barRequiredNullable ??= '';
  props.barRequiredInt |= 1;

  otherCallback((p) => p.barRequired);

  // Unrelated conditional reads
  if (props.containsProp((p) => p.barRequiredInt)) {
    print(props.barRequired);
  }
  final otherProps = Bar();
  if (otherProps.containsProp((p) => p.barRequired)) {
    print(props.barRequired);
  }

  // Unsafe complex contains prop nesting
  if (props.containsProp((p) => p.barRequired)) {
    Future(() {
      print(props.barRequired);
    });
  }

  // Safe

  // Safe write
  props.barRequired = '';

  // Reading props from a component is safe
  print(component.props.barRequired);

  // Safe non-required read
  print(props.notRequired);
  // Safe helper method accesses
  print(props.getRequiredPropOrNull((p) => p.barRequired));
  print(props.getRequiredProp((p) => p.barRequired, orElse: () => 'foo'));
  print(props.getPropKey((p) => p.barRequired));
  print(props.containsProp((p) => p.barRequired));
  // Safe conditional read.
  if (props.containsProp((p) => p.barRequired)) {
    print(props.barRequired);
  }
}

otherCallback(Function(BarProps) callback) {}
