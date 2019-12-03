import '../../component_base.dart';

typedef UiHoc<TProps extends UiProps> = UiFactory<TProps> Function(UiFactory<TProps>);

// R doesn't have bounds of UiHoc since the analyzer doesn't handle that well.
R Function(A) composeHocs<R, A extends R>(Iterable<R Function(A)> functions) {
  return functions.reduce((a, b) => (result) => a(b(result)));
}

