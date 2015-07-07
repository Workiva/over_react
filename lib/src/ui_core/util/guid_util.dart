part of w_ui_platform.ui_core;

/// Randomly generate a GUID with the give length
String generateGuid([length = 16]) {
  Random rand = new Random();

  String guid = '';
  for (var i = 0; i < length; i++) {
    guid += rand.nextInt(100).toRadixString(16).substring(0, 1);
  }

  return guid;
}
