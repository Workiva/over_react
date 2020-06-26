import 'package:over_react/over_react.dart';

const myRelTarget = 'nofollow';
const myRelTarget2 = 'noopener noreferrer';
final myRelTarget3 = 'noopener';

final noRel = (Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
)();

final relWithIrrelevantValue = (Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
  ..rel = 'nofollow'
)();

final relWithOneRelevantValue = (Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
  ..rel = 'noopener'
)();

final relWithConstValue = (Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
  ..rel = myRelTarget
)();

final relWithNonConstValue = (Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
  ..rel = myRelTarget3
)();

ReactElement relWithLocalConstValue() {
  const invalidLocalRel = 'nofollow';
  const validLocalRel = myRelTarget2;

  final invalid = (Dom.a()
    ..href = 'https://www.workiva.com'
    ..target = '_blank' // Should lint
    ..rel = invalidLocalRel
  )();

  final valid = (Dom.a()
    ..href = 'https://www.workiva.com'
    ..target = '_blank' // Should not lint
    ..rel = validLocalRel
  )();
}

final relIsNull = (Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
  ..rel = null
)();

final shouldNotLint = (Dom.a()
  ..target = '_blank'
)('I have no href, so the target value is not a security vulnerability yet');

final shouldNotLint2 = (Dom.a()
  ..href = null
  ..target = '_blank'
)('I have no href, so the target value is not a security vulnerability yet');

final shouldNotLint3 = (Dom.a()
  ..href = 'https://www.workiva.com'
)('I have no target, so the link is not a security vulnerability yet');

final shouldNotLint4 = (Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = null
)('I have no target, so the link is not a security vulnerability yet');

final shouldNotLint5 = (Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
  ..rel = myRelTarget2
)('My rel value is good to go!');
