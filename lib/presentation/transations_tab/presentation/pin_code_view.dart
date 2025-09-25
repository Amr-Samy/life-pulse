import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';
import 'package:life_pulse/presentation/transations_tab/presentation/top_up_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? _code;
  bool _isCodeComplete = false;

  @override
  Widget build(BuildContext context) {
    return SensitiveContent(
      sensitivity: ContentSensitivity.sensitive,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.walletPassword.tr),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppStrings.enterVerificationCode.tr,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              VerificationCode(
                fullBorder: true,
                itemSize: 50,
                padding: const EdgeInsets.all(4),
                margin: EdgeInsets.all(4),
                underlineColor: Colors.blueAccent,
                length: 6,
                keyboardType: TextInputType.number,
                onCompleted: (String value) {
                  setState(() {
                    _code = value;
                    _isCodeComplete = true;
                  });
                },
                onEditing: (bool value) {
                  if (value) {
                    setState(() {
                      _isCodeComplete = false;
                    });
                  }
                },
              ),
              const SizedBox(height: 40),
              if (_isCodeComplete)
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const TopUpScreen());
                  },
                  child: const Text('Verify'),
                )
              else
                const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
