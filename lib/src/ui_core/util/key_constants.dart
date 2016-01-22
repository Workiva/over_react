library key_constants;

/// Key values that are returned from [react.SyntheticKeyboardEvent.key].
///
///See: <https://w3c.github.io/uievents/#h-fixed-virtual-key-codes>.
abstract class KeyValue {
  static const String BACKSPACE = 'Backspace';
  static const String TAB = 'Tab';
  static const String ENTER = 'Enter';
  static const String SHIFT = 'Shift';
  static const String CONTROL = 'Control';
  static const String ALT = 'Alt';
  static const String CAPS_LOCK = 'CapsLock';
  static const String ESC = 'Escape';
  static const String SPACE  = ' ';
  static const String PAGE_UP = 'PageUp';
  static const String PAGE_DOWN = 'PageDown';
  static const String END = 'End';
  static const String HOME = 'Home';
  static const String ARROW_LEFT = 'ArrowLeft';
  static const String ARROW_UP = 'ArrowUp';
  static const String ARROW_RIGHT = 'ArrowRight';
  static const String ARROW_DOWN = 'ArrowDown';
  static const String DELETE = 'Delete';


  /// All of the [KeyValue] values.
  static const List<String> values = const <String>[
    BACKSPACE,
    TAB,
    ENTER,
    SHIFT,
    CONTROL,
    ALT,
    CAPS_LOCK,
    ESC,
    SPACE,
    PAGE_UP,
    PAGE_DOWN,
    END,
    HOME,
    ARROW_LEFT,
    ARROW_UP,
    ARROW_RIGHT,
    ARROW_DOWN,
    DELETE
  ];
}
