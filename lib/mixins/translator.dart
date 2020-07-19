import 'package:flutter_translate/flutter_translate.dart' as flutter_translate;

abstract class Translator {
  // Intended to be used as a mixin.
  factory Translator._() => null;

  String translate(String key) {
    try {
      return flutter_translate.translate(key);
    } catch (Exception) {
      return key;
    }
  }
}
