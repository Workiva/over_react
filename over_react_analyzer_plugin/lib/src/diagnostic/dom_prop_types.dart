import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

/// A diagnostic that warns when an HTML attribute set on an OverReact `Dom` component builder is invalid
/// based on the `<attribute>: [<allowed_html_elems>]` schema found within [allowedHtmlElementsForAttribute].
class InvalidDomAttributeDiagnostic extends ComponentUsageDiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_invalid_dom_attribute',
    "'{0}' isn't a valid HTML attribute prop for '{1}'. It may only be used on: {2}",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  @override
  computeErrorsForUsage(result, collector, usage) async {
    // todo support SVG icons
    // Don't support SVG icons since we only have HTML element metadata.
    if (!usage.isDom || usage.isSvg) return;

    final nodeName = usage.componentName;
//    if (usage.isSvg && nodeName != 'svg') {
//      nodeName = nodeName.replaceFirst(new RegExp(r'^svg'), '');
//    }

    forEachCascadedProp(usage, (lhs, rhs) {
      final propName = lhs.propertyName.name;
      if (propName == null) return; // just in case

      final allowedElements = getAttributeMeta(propName);
      if (allowedElements == null) return;

      if (!allowedElements.contains(nodeName)) {
        collector.addError(code, result.locationFor(lhs.propertyName),
            errorMessageArgs: [propName, 'Dom.$nodeName()', allowedElements.map((name) => 'Dom.$name()').join(',')]);
      }
    });
  }
}

List<String> getAttributeMeta(String propName) {
  return allowedHtmlElementsForAttribute[propName] ??
      allowedHtmlElementsForAttribute[propName.toLowerCase()] ??
      allowedHtmlElementsForAttribute[_camelToSpinalCase(propName)];
}

String _camelToSpinalCase(String camel) {
  return camel
      .replaceAllMapped(
        RegExp(r'([^A-Z])([A-Z])'),
        (match) => '${match.group(1)}-${match.group(2)}',
      )
      .toLowerCase();
}

/// A map keyed with HTML attributes and iterable values of the HTML element names they are allowed on.
///
/// > See: [InvalidDomAttributeDiagnostic]
const allowedHtmlElementsForAttribute = {
  'accept': ['form', 'input'],
  'accept-charset': ['form'],
  'action': ['form'],
  'align': [
    'applet',
    'caption',
    'col',
    'colgroup',
    'hr',
    'iframe',
    'img',
    'table',
    'tbody',
    'td',
    'tfoot',
    'th',
    'thead',
    'tr'
  ],
  'allow': ['iframe'],
  'alt': ['applet', 'area', 'img', 'input'],
  'async': ['script'],
  'autocomplete': ['form', 'input', 'textarea'],
  'autofocus': ['button', 'input', 'keygen', 'select', 'textarea'],
  'autoplay': ['audio', 'video'],
  'bgcolor': ['body', 'col', 'colgroup', 'marquee', 'table', 'tbody', 'tfoot', 'td', 'th', 'tr'],
  'border': ['img', 'object', 'table'],
  'buffered': ['audio', 'video'],
  'challenge': ['keygen'],
  'charset': ['meta', 'script'],
  'checked': ['command', 'input'],
  'cite': ['blockquote', 'del', 'ins', 'q'],
  'code': ['applet'],
  'codebase': ['applet'],
  'color': ['basefont', 'font', 'hr'],
  'cols': ['textarea'],
  'colspan': ['td', 'th'],
  'content': ['meta'],
  'controls': ['audio', 'video'],
  'coords': ['area'],
  'crossorigin': ['audio', 'img', 'link', 'script', 'video'],
  'csp ': ['iframe'],
  'data': ['object'],
  'datetime': ['del', 'ins', 'time'],
  'decoding': ['img'],
  'default': ['track'],
  'defer': ['script'],
  'dirname': ['input', 'textarea'],
  'disabled': ['button', 'command', 'fieldset', 'input', 'keygen', 'optgroup', 'option', 'select', 'textarea'],
  'download': ['a', 'area'],
  'enctype': ['form'],
  'for': ['label', 'output'],
  'form': [
    'button',
    'fieldset',
    'input',
    'keygen',
    'label',
    'meter',
    'object',
    'output',
    'progress',
    'select',
    'textarea'
  ],
  'formaction': ['input', 'button'],
  'headers': ['td', 'th'],
  'height': ['canvas', 'embed', 'iframe', 'img', 'input', 'object', 'video'],
  'high': ['meter'],
  'href': ['a', 'area', 'base', 'link'],
  'hreflang': ['a', 'area', 'link'],
  'http-equiv': ['meta'],
  'icon': ['command'],
  'importance ': ['iframe', 'img', 'link', 'script'],
  'integrity': ['link', 'script'],
  'ismap': ['img'],
  'keytype': ['keygen'],
  'kind': ['track'],
  'label': ['track'],
  'language': ['script'],
  'lazyload ': ['img', 'iframe'],
  'list': ['input'],
  'loop': ['audio', 'bgsound', 'marquee', 'video'],
  'low': ['meter'],
  'manifest': ['html'],
  'max': ['input', 'meter', 'progress'],
  'maxlength': ['input', 'textarea'],
  'minlength': ['input', 'textarea'],
  'media': ['a', 'area', 'link', 'source', 'style'],
  'method': ['form'],
  'min': ['input', 'meter'],
  'multiple': ['input', 'select'],
  'muted': ['audio', 'video'],
  'name': [
    'button',
    'form',
    'fieldset',
    'iframe',
    'input',
    'keygen',
    'object',
    'output',
    'select',
    'textarea',
    'map',
    'meta',
    'param'
  ],
  'novalidate': ['form'],
  'open': ['details'],
  'optimum': ['meter'],
  'pattern': ['input'],
  'ping': ['a', 'area'],
  'placeholder': ['input', 'textarea'],
  'poster': ['video'],
  'preload': ['audio', 'video'],
  'radiogroup': ['command'],
  'readonly': ['input', 'textarea'],
  'referrerpolicy': ['a', 'area', 'iframe', 'img', 'link', 'script'],
  'rel': ['a', 'area', 'link'],
  'required': ['input', 'select', 'textarea'],
  'reversed': ['ol'],
  'rows': ['textarea'],
  'rowspan': ['td', 'th'],
  'sandbox': ['iframe'],
  'scope': ['th'],
  'scoped': ['style'],
  'selected': ['option'],
  'shape': ['a', 'area'],
  'size': ['input', 'select'],
  'sizes': ['link', 'img', 'source'],
  'span': ['col', 'colgroup'],
  'src': ['audio', 'embed', 'iframe', 'img', 'input', 'script', 'source', 'track', 'video'],
  'srcdoc': ['iframe'],
  'srclang': ['track'],
  'srcset': ['img', 'source'],
  'start': ['ol'],
  'step': ['input'],
  'summary': ['table'],
  'target': ['a', 'area', 'base', 'form'],
  'type': ['button', 'input', 'command', 'embed', 'object', 'script', 'source', 'style', 'menu'],
  'usemap': ['img', 'input', 'object'],
  'value': ['button', 'option', 'input', 'li', 'meter', 'progress', 'param'],
  'width': ['canvas', 'embed', 'iframe', 'img', 'input', 'object', 'video'],
  'wrap': ['textarea'],
};
