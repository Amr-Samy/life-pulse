// lib/pin_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../../resources/values_manager.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final int _pinLength = 5;
  String _pin = '';
  bool _onEditing = true;
  //TODO auto capture from clipboard ( like in otp_view )
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Enter PIN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(

                children: [
                  const Text(
                    'Please Enter your PIN',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),

            // Using the flutter_verification_code widget
            VerificationCode(
              length: _pinLength,
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              keyboardType: TextInputType.number,
              // Styling for the underline
              underlineColor: Colors.green,
              underlineWidth: 3,
              underlineUnfocusedColor: Colors.grey[300]!,
              // Sizing
              itemSize: AppSize.s50,
              autofocus: true,
               fullBorder: true,
              // Fires when all digits are entered
              onCompleted: (String value) {
                setState(() {
                  _pin = value;
                });
              },
              // Fires when the user starts/stops editing
              onEditing: (bool value) {
                setState(() {
                  _onEditing = value;
                });
                if (!_onEditing) {
                  FocusScope.of(context).unfocus();
                }
              },
                digitsOnly: true,
                // pasteStream:  signInController.pasteCode,
                margin: EdgeInsets.symmetric(horizontal: AppMargin.m8),


                fillColor: Theme.of(context).cardColor,
            ),

                  const SizedBox(height: 50),
                  _buildConfirmButton(),
                ],
              ),
            ),
    );
  }

  // Builds the Confirm button, which is disabled until the PIN is fully entered
  Widget _buildConfirmButton() {
    bool isEnabled = _pin.length == _pinLength;
    const Color primaryColor = Color(0xFF1DB954);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
          // TODO: Implement PIN confirmation logic
          print('PIN Confirmed: $_pin');
                FocusScope.of(context).unfocus(); // Hide keyboard
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PIN $_pin confirmed!')),
          );
        }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          disabledBackgroundColor: Colors.green.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Confirm',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}