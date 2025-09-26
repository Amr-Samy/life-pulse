import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/presentation/resources/routes_manager.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import '../../../data/network/api.dart';
import '../../resources/helpers/functions.dart';
import '../../resources/helpers/storage.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isPasswordConfirmationHidden = true.obs;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController mobileTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController passwordConfirmationTextController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.nameIsRequired.tr;
    }
    return null;
    }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailIsRequired.tr;
    }
    if (!GetUtils.isEmail(value.trim())) {
      return AppStrings.invalidEmailFormat.tr;
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneNumberIsRequired.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordIsRequired.tr;
    }
    if (value.length < 8) {
      return AppStrings.passwordMustBe8Chars.tr;
    }
    return null;
    }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPassword.tr;
    }
    if (value != passwordTextController.text) {
      return AppStrings.passwordsDoNotMatch.tr;
    }
    return null;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      dynamic data = {
        "name": nameTextController.text.trim(),
        "mobile": mobileTextController.text.trim(),
        "email": emailTextController.text.trim(),
        "password": passwordTextController.text,
        "password_confirmation": passwordConfirmationTextController.text,
        "device_token": GetStorage().read('deviceToken'),
      };

      var response = await Api().post('register', data: data);

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = json.decode(responseData);
      }

      bool success = responseData['success'] ?? false;
      String message = responseData['message'] ?? AppStrings.anUnknownErrorOccurred.tr;

      if (success) {
        final secureStorage = TokenStorage();
        await secureStorage.saveToken(responseData['token']);
        showSuccessSnackBar(message: message);
        Get.offAllNamed(Routes.mainRoute);
      } else {
        String errorMessage = message;
        if (responseData.containsKey('errors') && responseData['errors'] is Map) {
          final errors = responseData['errors'] as Map;
          if (errors.isNotEmpty) {
            errorMessage = errors.values.map((e) => e.join('\n')).join('\n');
          }
        }
        showErrorSnackBar(message: errorMessage);
      }
    } catch (e) {
      showErrorSnackBar(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
