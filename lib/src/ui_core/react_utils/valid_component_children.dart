part of ui_core;

bool hasValidComponent(dynamic children) {
  JsObject reactJs = context['React'];
  JsObject reactJsChildren = context['React']['Children'];

  var hasValid = false;
  reactJsChildren.callMethod('forEach', [children, (child) {
    if (!hasValid && reactJs.callMethod('isValidElement', [child])) {
      hasValid = true;
    }
  }, reactJs]);

  return hasValid;
}






///**
// * Determine if the Child container has one or more "valid components".
// *
// * @param {?*} children Children tree container.
// * @returns {boolean}
// */
//function hasValidComponent(children) {
//  var hasValid = false;
//
//  React.Children.forEach(children, function (child) {
//  if (!hasValid && React.isValidElement(child)) {
//  hasValid = true;
//  }
//  });
//
//  return hasValid;
//}
