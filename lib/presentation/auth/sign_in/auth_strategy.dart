import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart' show PlatformException;
import '../../../data/model/signIn.dart';
import '../../../data/network/api.dart';

abstract class AuthenticationStrategy {
  Future<String?> authenticate();
}

// Concrete Email Authentication Strategy
class EmailAuthentication implements AuthenticationStrategy {
  final String email;
  final String password;
  final Api api;

  EmailAuthentication(this.email, this.password, this.api);

  @override
  Future<String?> authenticate() async {

    dynamic body = {
      'email': email,
      'password': password,
    };

    try {
      var response = await api.post('sign_in', data: body);
      var signInModel = SignInModel.fromJson(response.data);

      if (signInModel.status != "success") {
        throw Exception(signInModel.message ?? "Authentication failed");
      }

      return signInModel.token;
    } catch (e) {
      throw Exception("Email authentication failed: ${e.toString()}");
    }
  }
}

// Concrete Google Authentication Strategy
class GoogleAuthentication implements AuthenticationStrategy {
  final GoogleSignIn _googleSignIn;
  final Api api;

  GoogleAuthentication(this._googleSignIn, this.api);

  @override
  Future<String> authenticate() async {
    try {
      // Check if Google Sign-In is available
      bool isSignedIn = await _googleSignIn.isSignedIn();
      debugPrint("Is Google Sign-In available? $isSignedIn");

      debugPrint("Attempting Google Sign-In...");
      final GoogleSignInAccount? account = await _googleSignIn.signIn().catchError((e) {
        debugPrint("SignIn error: $e");
        throw e;
      });

      // Check if the user canceled the sign-in
      if (account == null) {
        debugPrint("Google Sign-In failed: No account returned (possibly canceled or misconfigured)");
        throw Exception("Google Sign-In failed: No account selected or configuration error");
      }

      debugPrint("Google Sign-In successful. Account: ${account.email}"); // ✅
      final GoogleSignInAuthentication auth = await account.authentication;

      // final credential = GoogleAuthProvider.credential(
      //   accessToken: auth.accessToken,
      //   idToken: auth.idToken,
      // );
      // final FirebaseAuth authInstance = FirebaseAuth.instance;
      // await authInstance.signInWithCredential(credential);


      // Verify idToken is not null
      if (auth.idToken == null) {
        debugPrint("Google Sign-In failed: idToken is null");
        await _googleSignIn.signOut(); // Sign out if idToken is null
        throw Exception("Google Sign-In failed: idToken is null");
      }

      // Log the idToken for debugging
      debugPrint("Google idToken: ${auth.idToken}");

      // Make API request
      final response = await api.post(
        "google_login",
        data: {"id_token": auth.idToken},
      );

      // Log the request body
      debugPrint("Request body: {\"id_token\": \"${auth.idToken}\"}");

      // Check for token in response
      if (response.data["token"] == null) {
        debugPrint("API response: ${response.data}");
        String errorMessage = response.data["message"] ?? response.data["error"] ?? "No token in API response";
        await _googleSignIn.signOut(); // Sign out if backend response is invalid
        throw Exception("Google Sign-In failed: $errorMessage");
      }

      debugPrint("API response contains token: ${response.data}");
      return response.data["token"];
      // return auth.idToken!;
    } on PlatformException catch (e) {
      debugPrint("PlatformException during Google Sign-In: ${e.code}, ${e.message}");
      await _googleSignIn.signOut(); // Sign out on platform exception
      throw Exception("Google Sign-In failed: ${e.message}");
    } catch (e,stackTrace) {
      debugPrint("Google authentication error: $e\nStack trace: $stackTrace");
      await _googleSignIn.signOut(); // Sign out on any other error
      throw Exception("Google authentication failed: ${e.toString()}");
    }
  }
}

// Concrete Facebook Authentication Strategy
class FacebookAuthentication implements AuthenticationStrategy {
  final Api api;

  FacebookAuthentication(this.api);

  @override
  Future<String> authenticate() async {
    try {
      final result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        throw Exception("Facebook login failed");
      }

      final userData = await FacebookAuth.instance.getUserData(
          fields: "email,name,picture"
      );

      final response = await api.post(
        "auth/facebook",
        data: {
          "access_token": result.accessToken!.tokenString,
          "email": userData["email"],
          "name": userData["name"],
          "picture": userData["picture"]["data"]["url"],
        },
      );

      return response.data["token"];
    } catch (e) {
      throw Exception("Facebook authentication failed: ${e.toString()}");
    }
  }
}
