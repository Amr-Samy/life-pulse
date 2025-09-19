import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/presentation/resources/routes_manager.dart';
import '../../../data/network/api.dart';
import '../../resources/helpers/functions.dart';

class SignUpController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isPasswordConfirmationHidden = true.obs;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController mobileTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController passwordConfirmationTextController = TextEditingController();

  Future<void> register() async {
    try {
    isLoading.value = true ;
      if (passwordTextController.text != passwordConfirmationTextController.text) {
        showErrorSnackBar(message: "Passwords do not match.");
        return;
      }

      dynamic data = {
        "name": nameTextController.text,
        "mobile": mobileTextController.text,
        "email": emailTextController.text,
        "password": passwordTextController.text,
        "password_confirmation": passwordConfirmationTextController.text
      };

      var response = await Api().post('register', data: data);

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = json.decode(responseData);
      }

      bool success = responseData['success'] ?? false;
      String message = responseData['message'] ?? 'An unknown error occurred.';

      if (success) {
        GetStorage storage = GetStorage();
        storage.write('token', responseData['token']);
        showSuccessSnackBar(message: message);
        Get.offAllNamed(Routes.mainRoute);

        } else{
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
        isLoading.value = false ;
      }
    }
}

