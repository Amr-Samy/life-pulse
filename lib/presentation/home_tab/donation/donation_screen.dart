import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../donations_tab/controllers/donations_controller.dart';
import '../../profile_tab/profile/profile_controller.dart';
import '../../resources/index.dart';

class DonationScreen extends StatefulWidget {
  final int campaignId;
  const DonationScreen({super.key, required this.campaignId});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  static const int _maxDonationAmount = 100000;
  final List<int> _suggestedAmounts = [5, 10, 25, 50, 100, 200];
  int _selectedAmount = 10;
  late bool _isAnonymous;
  final TextEditingController _amountController = TextEditingController();
  String? _errorMessage;

  final ProfileController _profileController = Get.find<ProfileController>(tag: "ProfileController");
  final DonationsController _donationsController = Get.find<DonationsController>();


  @override
  void initState() {
    super.initState();
    _amountController.text = _selectedAmount.toString();
    _isAnonymous = _profileController.isAnonymous.value;
    _validateAmount(_selectedAmount);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _validateAmount(int amount) {
    setState(() {
      final walletBalance = double.tryParse(_profileController.walletBalance.value) ?? 0.0;
      if (amount > _maxDonationAmount) {
        _errorMessage =
        'Maximum donation is EGP ${_maxDonationAmount.toStringAsFixed(0)}';
      } else if (amount <= 0) {
        _errorMessage = 'Please enter an amount greater than zero';
      } else if (!isGuest() && amount > walletBalance) {
        _errorMessage = 'Insufficient wallet balance';
      } else {
        _errorMessage = null;
      }
    });
  }

  void _updateAmount(int amount) {
    setState(() {
      _selectedAmount = amount;
      _amountController.text = amount.toString();
      _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length),
      );
    });
    _validateAmount(amount);
  }

  Future<void> _handleDonation() async {
    if (isGuest()) {
      Get.snackbar(
        "Login Required",
        "Please log in to make a donation.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    final success = await _donationsController.makeDonation(
      campaignId: widget.campaignId,
      amount: _selectedAmount,
      isAnonymous: _isAnonymous,
    );
    if (success && mounted) {
      Get.back();
      showSuccessSnackBar(message: "تم التبرع بنجاح");
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1DB954);
    const Color lightGreenBg = Color(0xFFF0F9F4);

    return Scaffold(
      backgroundColor: lightGreenBg,
      appBar: AppBar(
        title: const Text('Donate', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_pattern.png'),
              fit: BoxFit.cover,
              opacity: 1,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Enter the Amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            _buildAmountTextField(primaryColor),
            const SizedBox(height: 24),
            _buildAmountSuggestions(primaryColor),
            const SizedBox(height: 32),
            _buildAnonymousCheckbox(primaryColor),
            const SizedBox(height: 40),
            _buildContinueButton(primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountTextField(Color primaryColor) {
    return TextField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      decoration: InputDecoration(
        prefixText: 'EGP ',
        prefixStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: primaryColor, width: 2.5),
        ),
        errorText: _errorMessage,
        errorStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        errorMaxLines: 2,
      ),
      onChanged: (value) {
        final amount = int.tryParse(value) ?? 0;
        setState(() {
          _selectedAmount = amount;
        });
        _validateAmount(amount);
      },
    );
  }

  Widget _buildAmountSuggestions(Color primaryColor) {
    return GridView.count(
      crossAxisCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
      childAspectRatio: 2.1,
      children: _suggestedAmounts.map((amount) {
        final isSelected = _selectedAmount == amount;
        return GestureDetector(
          onTap: () => _updateAmount(amount),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey[300]!,
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
                  : [],
            ),
            child: Text(
              'EGP $amount',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnonymousCheckbox(Color primaryColor) {
    return GestureDetector(
      onTap: () => setState(() {
        _isAnonymous = !_isAnonymous;
        _profileController.toggleAnonymous(_isAnonymous);
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: _isAnonymous,
            onChanged: (bool? value) => setState(() {
              _isAnonymous = value ?? false;
              _profileController.toggleAnonymous(_isAnonymous);
            }),
            activeColor: primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: BorderSide(color: Colors.grey[400]!, width: 2),
          ),
          const Text('Donate as anonymous', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildContinueButton(Color primaryColor) {
    final bool isButtonEnabled = _errorMessage == null;

    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => ElevatedButton(
          onPressed: isButtonEnabled && !_donationsController.isDonating.value ? _handleDonation : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          disabledBackgroundColor: Colors.grey.withOpacity(0.6),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 0,
        ),
          child: _donationsController.isDonating.value
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        )
            : const Text(
          'Continue',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      ),
    );
  }
}