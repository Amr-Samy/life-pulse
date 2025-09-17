import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/index.dart';
import '../wallet_pin/pin_screen.dart';

enum PaymentMethod { wallet, paypal, googlePay, applePay }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.wallet;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1DB954);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_pattern.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildPaymentOption(
              method: PaymentMethod.wallet,
              icon: ImageAssets.payment,
              title: 'My Wallet (\$400)',
              color: primaryColor,
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              method: PaymentMethod.paypal,
              icon: ImageAssets.payPal,
              title: 'Paypal',
              color: const Color(0xFF00457C),
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              method: PaymentMethod.googlePay,
              icon: ImageAssets.google,
              title: 'Google Pay',
              color: Colors.black,
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              method: PaymentMethod.applePay,
              icon: ImageAssets.apple,
              title: 'Apple Pay',
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            _buildAddNewCardButton(),
            const Spacer(),
            _buildContinueButton(primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required PaymentMethod method,
    required String icon,
    required String title,
    required Color color,
  }) {
    final bool isSelected = _selectedMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF1DB954) : Colors.grey[300]!,
            width: isSelected ? 2.0 : 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFF1DB954).withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Row(
          children: [
            Image.asset(icon, color: color, width: 24, height: 24),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF1DB954), size: 26)
            else
              Icon(Icons.radio_button_unchecked, color: Colors.grey[300], size: 26),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return GestureDetector(
      onTap: () {
        // TODO: Handle navigation to add new card screen
        print('Add New Card tapped');
      },
      child: DottedBorder(
        color: Colors.grey,
        strokeWidth: 1.5,
        radius: const Radius.circular(12),
        borderType: BorderType.RRect,
        dashPattern: const [6, 5],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.black54, size: 24),
              SizedBox(width: 12),
              Text(
                'Add New Card',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(Color primaryColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement payment processing logic
          print('Continue tapped with method: $_selectedMethod');
          switch (_selectedMethod) {
            case PaymentMethod.wallet:
              Get.to(PinScreen());
              break;
            case PaymentMethod.paypal:
              break;
            case PaymentMethod.googlePay:
              break;
            case PaymentMethod.applePay:
              break;
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Continue',
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