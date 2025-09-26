import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import '../controllers/pin_code_controller.dart';

class VerificationScreen extends GetView<PinCodeController> {
  const VerificationScreen({super.key});

    @override
  Widget build(BuildContext context) {
    Get.put(PinCodeController());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.walletPassword.tr),
      ),
      body: SensitiveContent(
        sensitivity: ContentSensitivity.sensitive,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Obx(() => _buildBody(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (controller.currentState.value) {
      case VerificationState.loading:
        return const CircularProgressIndicator();
      case VerificationState.error:
        return _buildErrorState(context);
      default:
        return _buildVerificationForm(context);
    }
  }
  Widget _buildErrorState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.redAccent, size: 60),
        const SizedBox(height: 16),
        Text(
          'An Error Occurred',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          controller.errorMessage.value,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => controller.checkIfPasswordExists(),
          child: const Text('Retry'),
        )
      ],
    );
  }

  Widget _buildVerificationForm(BuildContext context) {
    String title = '';
    String subtitle = AppStrings.enterVerificationCode.tr;

    switch (controller.currentState.value) {
      case VerificationState.setPassword:
        title = AppStrings.setYourWalletPinTitle.tr;
        subtitle = AppStrings.setYourWalletPinSubtitle.tr;
        break;
      case VerificationState.confirmPassword:
        title = AppStrings.confirmYourPinTitle.tr;
        subtitle = AppStrings.confirmYourPinSubtitle.tr;
        break;
      case VerificationState.verifyPassword:
        title = AppStrings.enterYourPinTitle.tr;
        subtitle = AppStrings.enterYourPinSubtitle.tr;
        break;
      default:
        break;
    }

    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Icon(
          Icons.security_rounded,
          size: 70,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
            Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
            ),
        const SizedBox(height: 40),
            VerificationCode(
          key: ValueKey(controller.currentState.value),
              fullBorder: true,
              itemSize: 50,
          textStyle: const TextStyle(fontSize: 24, color: Colors.black),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          underlineColor: Theme.of(context).primaryColor,
              length: 6,
              keyboardType: TextInputType.number,
              onCompleted: (String value) {
            controller.onPinCompleted(value);
              },
          onEditing: (bool value) {},
            ),
            const SizedBox(height: 40),
        Obx(() => controller.isLoadingOnSubmit.value
            ? const CircularProgressIndicator()
            : const SizedBox(height: 48)),
          ],
    );
  }
}
