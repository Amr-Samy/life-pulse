import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/data/network/api.dart';
import 'package:life_pulse/presentation/resources/helpers/storage.dart';
import 'package:life_pulse/presentation/resources/routes_manager.dart';
import '../../resources/helpers/functions.dart';

class SignInController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isNewPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden = true.obs;
  String error = '';
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  Future<void> signIn() async {
    try {
      isLoading.value = true;
      final box = GetStorage();
      dynamic body = {
        'mobile': mobileTextController.text,
        'password': passwordTextController.text,
        'device_token': box.read('deviceToken'),
      };

      var response = await Api().post('login', data: body);

      dynamic responseData = response.data;
      if (responseData is String) {
        debugPrint('Response data is a string, decoding manually.');
        responseData = json.decode(responseData);
      }

      debugPrint('Server response: $responseData');

      bool success = responseData['success'] ?? false;
      String message = responseData['message'] ?? 'An unknown error occurred.';
      debugPrint('token: ${responseData['token']}');

      if (success) {
        String? token = responseData['token'];
        if (token != null) {
          final secureStorage = TokenStorage();

          await secureStorage.saveToken(token);
          debugPrint("Token+++++++++++++++++++++++++++++++++: ${secureStorage.getToken()}");
          Get.offAllNamed(Routes.mainRoute);
        } else {
          throw Exception("Login successful but no token was provided.");
        }
      } else {
        showErrorSnackBar(message: message);
      }
    } catch (e, s) {
      debugPrint('Error during sign in: $e');
      debugPrint('Stack trace: $s');
      showErrorSnackBar(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
