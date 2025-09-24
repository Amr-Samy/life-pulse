import 'index.dart';
import 'language/ar.dart';

import 'language/en.dart';

class LocalizationApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ene: en,
        ara: ar,
        // From th.dart
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
