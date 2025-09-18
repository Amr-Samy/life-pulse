// Authentication Factory
import 'package:get/get_utils/get_utils.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import '../../../../data/network/api.dart';
import '../../../resources/strings_manager.dart';
import '../auth_strategy.dart';

class AuthenticationFactory {
  final Api api;
  // final GoogleSignIn googleSignIn;

  AuthenticationFactory(this.api,
      // this.googleSignIn
      );

  // AuthenticationStrategy createStrategy(AuthMethod method, {String? email, String? password}) {
  //   switch (method) {
  //     case AuthMethod.email:
  //       if (email == null || password == null) {
  //         throw ArgumentError(AppStrings.emailPasswordRequired.tr);
  //       }
  //       return EmailAuthentication(email, password, api);
  //     case AuthMethod.google:
  //       // return GoogleAuthentication(googleSignIn, api);
  //     case AuthMethod.facebook:
  //       // return FacebookAuthentication(api);
  //   }
  // }
}

// Enum for Authentication Methods
enum AuthMethod {
  email,
  google,
  facebook
}