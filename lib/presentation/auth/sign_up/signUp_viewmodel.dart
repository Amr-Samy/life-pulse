import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/auth/sign_up/signUp_strategy.dart';
import 'package:life_pulse/presentation/resources/color_manager.dart';
import 'package:life_pulse/presentation/resources/routes_manager.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';

import '../../resources/helpers/functions.dart';
import 'factory/registration_factory.dart';

class SignUpController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  String error = '';
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  final RegistrationFactory registrationFactory;

  SignUpController({required this.registrationFactory});

  Future<void> register(RegistrationMethod method) async {
    try {
    isLoading.value = true ;

      RegistrationStrategy strategy;

      if (method == RegistrationMethod.email) {
        strategy = registrationFactory.createStrategy(
          method,
          email: emailTextController.text,
          password: passwordTextController.text,
      );
      } else {
        strategy = registrationFactory.createStrategy(method);
      }

      final responseData = await strategy.register();

      String status = responseData['status'];
      String message = responseData['message'];

      if (status == "success") {
        showErrorSnackBar(
            message: AppStrings.checkMail.tr,
            icon: Icons.mark_email_unread_outlined,
          color: ColorManager.info,
        );

        Get.toNamed(
            Routes.signInRoute,
          arguments: {'email': emailTextController.text},
        );

        } else{
        error = message;
        showErrorSnackBar(message:  error.isNotEmpty ? error :"");
      }
    } catch (e) {
      showErrorSnackBar(message: error.isNotEmpty ? error : e.toString());
      throw Exception(e.toString());
    } finally {
        isLoading.value = false ;
      }
    }

  // Convenience methods
  Future<void> signUpWithEmail() => register(RegistrationMethod.email);
  Future<void> signUpWithGoogle() => register(RegistrationMethod.google);
  Future<void> signUpWithFacebook() => register(RegistrationMethod.facebook);
}

