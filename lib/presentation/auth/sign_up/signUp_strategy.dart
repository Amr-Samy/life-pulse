import 'dart:convert';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import '../../../data/network/api.dart';

// Registration Strategy Interface
abstract class RegistrationStrategy {
  Future<Map<String, dynamic>> register();
}

// Email Registration Strategy
class EmailRegistration implements RegistrationStrategy {
  final String email;
  final String password;
  final Api api;

  EmailRegistration(this.email, this.password, this.api);

  @override
  Future<Map<String, dynamic>> register() async {
    try {
      dynamic data = {
        "student": {
          "email": email,
          "password": password
        }
      };

      var response = await api.post('sign_up', data: data);

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = json.decode(responseData);
      }

      return responseData;
    } catch (e) {
      throw Exception("Registration failed: ${e.toString()}");
    }
  }
}

// Google Registration Strategy
// class GoogleRegistration implements RegistrationStrategy {
//   final Api api;
//   // final GoogleSignIn googleSignIn;
//
//   GoogleRegistration(this.api, this.googleSignIn);
//
//   @override
//   Future<Map<String, dynamic>> register() async {
//     try {
//       // final GoogleSignInAccount? account = await googleSignIn.signIn();
//       // final GoogleSignInAuthentication auth = await account!.authentication;
//
//       var data = {
//         "student": {
//           "email": account.email,
//           "google_token": auth.idToken,
//           "name": account.displayName,
//           "photo": account.photoUrl,
//         }
//       };
//
//       var response = await api.post('sign_up/google', data: data);
//       return response.data;
//     } catch (e) {
//       throw Exception("Google registration failed: ${e.toString()}");
//     }
//   }
// }
//
// // Facebook Registration Strategy
// class FacebookRegistration implements RegistrationStrategy {
//   final Api api;
//
//   FacebookRegistration(this.api);
//
//   @override
//   Future<Map<String, dynamic>> register() async {
//     try {
//       final result = await FacebookAuth.instance.login();
//
//       if (result.status != LoginStatus.success) {
//         throw Exception("Facebook login failed");
//       }
//
//       final userData = await FacebookAuth.instance.getUserData(
//           fields: "email,name,picture"
//       );
//
//       var data = {
//         "student": {
//           "email": userData["email"],
//           "facebook_token": result.accessToken!.tokenString,
//           "name": userData["name"],
//           "photo": userData["picture"]["data"]["url"],
//         }
//       };
//
//       var response = await api.post('sign_up/facebook', data: data);
//       return response.data;
//     } catch (e) {
//       throw Exception("Facebook registration failed: ${e.toString()}");
//     }
//   }
// }


