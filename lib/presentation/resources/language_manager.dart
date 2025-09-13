import 'index.dart';
import 'language/ar.dart';
import 'language/cn.dart';
import 'language/de.dart';
import 'language/en.dart';
import 'language/es.dart';
import 'language/fa.dart';
import 'language/fr.dart';
import 'language/ha.dart';
import 'language/id.dart';
import 'language/ru.dart';
import 'language/th.dart';
import 'language/tl.dart';
import 'language/tr.dart';
import 'language/ur.dart';

class LocalizationApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    ene: en,
    ara: ar,
    'fr': fr,  // From fr.dart
    'es': es,  // From es.dart
    'de': de,  // From de.dart
    'ru': ru,  // From ru.dart
    'ur': ur,  // From ur.dart
    'cn': cn,  // From cn.dart
    'id': id,  // From id.dart
    'fa': fa,  // From fa.dart
    'tr': tr,  // From tr.dart
    'tl': tl,  // From tl.dart
    'ha': ha,  // From ha.dart
    'th': th,  // From th.dart

  };
}

// enum LanguageType { ENGLISH, ARABIC }
//
// const String ARABIC = "ar";
// const String ENGLISH = "en";
//
// extension LanguageTypeExtension on LanguageType {
//   String getValue() {
//     switch (this) {
//       case LanguageType.ENGLISH:
//         return ENGLISH;
//       case LanguageType.ARABIC:
//         return ARABIC;
//     }
//   }
// }