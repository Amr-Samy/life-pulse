// Registration Factory
import 'package:get/get_utils/get_utils.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../../../../data/network/api.dart';
import '../../../resources/strings_manager.dart';
import '../signUp_strategy.dart';

class RegistrationFactory {
  final Api api;
  // final GoogleSignIn googleSignIn;

  RegistrationFactory(this.api,
      // this.googleSignIn
      );

  RegistrationStrategy createStrategy(RegistrationMethod method, {String? email, String? password}) {
    switch (method) {
      case RegistrationMethod.email:
        if (email == null || password == null) {
          throw ArgumentError(AppStrings.emailPasswordRequired.tr);
        }
        return EmailRegistration(email, password, api);
      case RegistrationMethod.google:
        // return GoogleRegistration(api
            // , googleSignIn
        // );
      case RegistrationMethod.facebook:
        // return FacebookRegistration(api);
        default:
          throw ArgumentError("Invalid registration method");
    }
  }
}

enum RegistrationMethod {
  email,
  google,
  facebook
}