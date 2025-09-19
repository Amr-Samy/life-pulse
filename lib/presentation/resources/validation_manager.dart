import 'package:get_storage/get_storage.dart';

import 'helpers/storage.dart';

class Validators {
  static String? validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }
}
  final storage = TokenStorage();
bool isGuest() {
  return TokenStorage.isGuest();
}