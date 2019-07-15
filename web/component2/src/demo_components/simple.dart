import 'package:over_react/over_react.dart';

import '../demo_components.dart';

part 'simple.over_react.g.dart';

/// Nest one or more `Simple` components within a [ListGroup]
/// to render individual items within a list.
///
/// See: <http://v4-alpha.getbootstrap.com/components/list-group/>
@Factory()
UiFactory<SimpleProps> Simple = _$Simple;

@Props()
class _$SimpleProps extends UiProps {}


@Component2()
class SimpleComponent<T extends SimpleProps> extends UiComponent2<T> {
  @override
  render() {
    return 'Simple';
  }
}
