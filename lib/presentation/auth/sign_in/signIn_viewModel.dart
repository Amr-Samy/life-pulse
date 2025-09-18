import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:life_pulse/data/model/signIn.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/assets_manager.dart';
import 'package:life_pulse/presentation/resources/color_manager.dart';
import 'package:life_pulse/presentation/resources/constants_manager.dart';
import 'package:life_pulse/presentation/resources/routes_manager.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import 'package:life_pulse/presentation/widgets/dialog.dart';

import '../../resources/helpers/functions.dart';
import '../../resources/helpers/storage.dart';
import 'auth_strategy.dart';
import 'factory/auth_factory.dart';

class SignInController extends GetxController {
  // GetStorage storage = GetStorage();
  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isNewPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden = true.obs;

  // RxBool checkedValue = false.obs;
  String error = '';
  String resetToken = '';
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  final AuthenticationFactory authFactory;
  final TokenStorage secureStorage;

  SignInController({
    required this.authFactory,
    required this.secureStorage,
  });

  //? //////////////// Sign In //////////////// //

  Future<void> authenticate(AuthMethod method) async {

    try {
    isLoading.value = true;

      AuthenticationStrategy strategy;

      // if (method == AuthMethod.email) {
      //   strategy = authFactory.createStrategy(
      //     method,
      //     email: emailTextController.text,
      //     password: passwordTextController.text,
      // );
      // } else {
      //   strategy = authFactory.createStrategy(method);
      // }

      // final token = await strategy.authenticate();
      // await secureStorage.saveToken(token);

      Get.offAllNamed(Routes.mainRoute);

    } catch (e) {
      showErrorSnackBar(message: e.toString());
    } finally {
        isLoading.value = false;
      }
    }

  Future<void> signInWithEmail() => authenticate(AuthMethod.email);
  Future<void> signInWithGoogle() => authenticate(AuthMethod.google);
  Future<void> signInWithFacebook() => authenticate(AuthMethod.facebook);


  //? //////////////// Forgot Password //////////////// //
  void goToForgotPassword() {
    Get.toNamed(Routes.forgotPasswordRoute);
    // if (emailTextController.text.isNotEmpty) {
    //
    // } else {
    //   showErrorSnackBar(message: AppStrings.emailPasswordRequired.tr);
    // }
  }

  //? //////////////// Encrypt Data //////////////// //
  RxString emailCharacter = ''.obs;

  void encryptEmail() {
    //TODO RETURN THE EMAIL AS IT IS IF NAME LENGTH < 3
    var name = emailTextController.text.split("@");
    emailCharacter.value =
        emailTextController.text.replaceRange(2, name[0].length, "*" * (name[0].length - 2));
  }

  //? //////////////// Forgot Password //////////////// //
  RxInt selectedRadioTile = 2.obs;
  RxInt selectedRadio = 0.obs;

  setSelectedRadioTile(int val) {
    selectedRadioTile.value = val;
  }

  Future<void> requestResetToken() async {
    isLoading.value = true;
    dynamic data = {"student": {"email": emailTextController.text}};

    try {
      var req = await Api().post(
        'reset-password',
        data: data,
      );

      // print("::::::::::::data.runtimeType: ${req.data.runtimeType}");
      // Parse response body
      dynamic responseData = req.data;
      if (responseData is String) {
        // Handle the case where response is a String
        responseData = json.decode(responseData);
      }
      // Read values
      String status = responseData['status'];
      String message = responseData['message'];
      debugPrint("::::::status:::::::::::$status::::::::::::::::::::::");
      debugPrint("::::::message::::::::::$message::::::::::::::::::::::");

      if (status == "success") {
        isLoading.value = false;

        resetToken = responseData['token'].toString();
        debugPrint("::::::resetToken::::::::::$resetToken::::::::::::::::::::::");


        // passwordTextController.clear();
        // emailTextController.clear();
        //
        showErrorSnackBar(
            title: AppStrings.note.tr,
            message: AppStrings.checkMail.tr,
            icon: Icons.mark_email_unread_outlined,
            color: ColorManager.info
        );

        Get.toNamed(Routes.otpRoute);
      } else {
        error = message ?? "";
        showErrorSnackBar(message: error.isNotEmpty ? error : "");

        isLoading.value = false;
      }
    } catch (err) {
      showErrorSnackBar(message: error.isNotEmpty ? error : err.toString());
      isLoading.value = false;
      throw Exception(err.toString());
    }
  }

  //? //////////////// OTP //////////////// //
  TextEditingController otpController = TextEditingController();
  RxString code = ''.obs;
  final StreamController<bool> _pasteCode = StreamController<bool>.broadcast();

  Stream<bool> get pasteCode => _pasteCode.stream;

  Sink<bool> get pasteCodeSink => _pasteCode;
  RxBool hasTimerStopped = false.obs;
  RxInt timer = 59.obs;

  void checkResetToken() {
    // if otp value == resetToken
    if (code.value == resetToken) {
      Navigator.pushReplacementNamed(Get.context!, Routes.newPasswordRoute);
    } else {
      showErrorSnackBar(message: "Wrong Code");
    }
  }

  //? //////////////// NEW Password //////////////// //
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool newPasswordRememberValue = false.obs;

  Future<void> updatePasswordAndSignIn() async {
    isLoading.value = true;

    dynamic data = {
      "student": {
        "email": emailTextController.text,
        "reset_password_token": code.value,
        "password": newPasswordController.text,
        "password_confirmation": confirmPasswordController.text
      }
    };

    try {
      var req = await Api().post(
        'update-password',
        data: data,
      );

      // debugPrint("::::::::::::data.runtimeType: ${req.data.runtimeType}");
      // Parse response body
      dynamic responseData = req.data;
      if (responseData is String) {
        // Handle the case where response is a String
        responseData = json.decode(responseData);
      }
      // Read values
      String status = responseData['status'];
      String message = responseData['message'];
      debugPrint("::::::status:::::::::::$status::::::::::::::::::::::");
      debugPrint("::::::message::::::::::$message::::::::::::::::::::::");

      if (status == "success") {
        isLoading.value = false;
        String token = responseData['token'];
        debugPrint("::::::token::::::::::$token::::::::::::::::::::::");
        final secureStorage = TokenStorage();
        await secureStorage.saveToken(token);
        // passwordTextController.clear();
        // emailTextController.clear();
        //
        showDialog<void>(
            context: Get.context!,
            builder: (context) =>
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  content: SuccessDialog(
                    image: ImageAssets.success,
                    title: AppStrings.congratulations.tr,
                    subTitle: AppStrings.accountReady.tr,
                    actions: ColorFiltered(
                      colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
                      child: Image.asset(
                        ImageAssets.loading,
                        height: 60,
                      ),
                    ),
                  ),
                )
        );

        Timer(const Duration(seconds: 1), () {
          Navigator.pop(Get.context!, true);
          Navigator.pushNamedAndRemoveUntil(
              Get.context!,
              Routes.mainRoute,
                  (Route<dynamic> route) => false
          );
        });
      } else {
        error = message ?? "";

        showErrorSnackBar(message: error.isNotEmpty ? error : "");
        isLoading.value = false;
      }
    } catch (err) {
      showErrorSnackBar(message: error.isNotEmpty ? error : err.toString());
      isLoading.value = false;
      throw Exception(err.toString());
    }
  }

  Future<void> resendOtp() async {
    try {
      // loading.value = true;
      // await _authRepository.resendResetCode(emailCharacter.value);

      hasTimerStopped.value = false;
      timer.value = 59;

      Get.snackbar(
        "Success",
      "A new code has been sent.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to resend code. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      // loading.value = false;
    }
  }

}