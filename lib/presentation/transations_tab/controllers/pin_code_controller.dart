import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/network/api.dart';
import '../../resources/strings_manager.dart';
import '../../transations_tab/presentation/top_up_screen.dart';

enum VerificationState {
  loading,
  setPassword,
  confirmPassword,
  verifyPassword,
  error
}

class PinCodeController extends GetxController {
  final Api _api = Api();

  var currentState = VerificationState.loading.obs;
  var isLoadingOnSubmit = false.obs;
  var errorMessage = "Something went wrong. Please try again.".obs;

  String? _firstPin;

  @override
  void onInit() {
    super.onInit();
    checkIfPasswordExists();
  }

  Future<void> checkIfPasswordExists() async {
    currentState.value = VerificationState.loading;
    try {
      final response = await _api.get("wallet/has-password");
      if (response.statusCode == 200 && response.data['success'] == true) {
        final bool hasPassword = response.data['has_password'];
        currentState.value = hasPassword
            ? VerificationState.verifyPassword
            : VerificationState.setPassword;
      } else {
        errorMessage.value = response.data['message'] ?? "Failed to check wallet status.";
        currentState.value = VerificationState.error;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      currentState.value = VerificationState.error;
    }
  }

  Future<void> onPinCompleted(String pin) async {
    isLoadingOnSubmit.value = true;
    try {
      switch (currentState.value) {
        case VerificationState.setPassword:
          _firstPin = pin;
          currentState.value = VerificationState.confirmPassword;
          break;
        case VerificationState.confirmPassword:
          if (pin == _firstPin) {
            await _setPassword(pin);
          } else {
            _showErrorSnackBar("PINs do not match. Please try again.");
            currentState.value = VerificationState.setPassword;
            _firstPin = null;
          }
          break;
        case VerificationState.verifyPassword:
          await _verifyPassword(pin);
          break;
        default:
          break;
      }
    } finally {
      isLoadingOnSubmit.value = false;
    }
  }

  Future<void> _setPassword(String pin) async {
    try {
      final response = await _api.post(
        "wallet/set-password",
        data: {
          "new_wallet_password": pin,
          "confirm_wallet_password": pin,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.off(() => const TopUpScreen());
      } else {
        _showErrorSnackBar(response.data['message'] ?? "Failed to set PIN.");
        currentState.value = VerificationState.setPassword;
        _firstPin = null;
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
      currentState.value = VerificationState.setPassword;
      _firstPin = null;
    }
  }

  Future<void> _verifyPassword(String pin) async {
    try {
      final response = await _api.post(
        "wallet/verify-password",
        data: {"wallet_password": pin},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.off(() => const TopUpScreen());
      } else {
        _showErrorSnackBar(response.data['message'] ?? "Invalid PIN.");
        currentState.value = VerificationState.verifyPassword;
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
      currentState.value = VerificationState.verifyPassword;
    }
  }

  void _showErrorSnackBar(String message) {
    Get.snackbar(
      AppStrings.error.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}