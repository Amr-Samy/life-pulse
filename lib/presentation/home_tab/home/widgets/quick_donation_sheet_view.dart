import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/donations_tab/controllers/donations_controller.dart';
import 'package:life_pulse/presentation/resources/helpers/functions.dart';

class DonationBottomSheet extends StatefulWidget {
  const DonationBottomSheet({super.key});

  @override
  State<DonationBottomSheet> createState() => _DonationBottomSheetState();
}

class _DonationBottomSheetState extends State<DonationBottomSheet> {
  int _selectedAmountIndex = -1;
  final List<int> _presetAmounts = [10, 50, 100];

  final TextEditingController _customAmountController = TextEditingController();
  final FocusNode _customAmountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _customAmountFocusNode.addListener(() {
      if (_customAmountFocusNode.hasFocus) {
        setState(() {
          _selectedAmountIndex = -1;
        });
      }
    });
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    _customAmountFocusNode.dispose();
    super.dispose();
  }

  void _selectPresetAmount(int index) {
    setState(() {
      _selectedAmountIndex = index;
      _customAmountController.clear();
      _customAmountFocusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF16a085);
    const Color darkGreyColor = Color(0xFF757575);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPresetAmounts(primaryColor),
          const SizedBox(height: 20),
          _buildCustomAmountField(primaryColor),
          const SizedBox(height: 16),
          _buildInfoText(darkGreyColor),
          const SizedBox(height: 24),
          _buildPaymentMethods(),
          const SizedBox(height: 24),

          // Donate Now Button
          ElevatedButton(
            onPressed: () async {
              int? amountToDonate;
              if (_selectedAmountIndex != -1) {
                amountToDonate = _presetAmounts[_selectedAmountIndex];
              } else if (_customAmountController.text.isNotEmpty) {
                amountToDonate = int.tryParse(_customAmountController.text);
              }
              if (amountToDonate == null || amountToDonate <= 0) {
                showErrorSnackBar(message:  'الرجاء اختيار أو إدخال مبلغ صحيح للتبرع',);
                return;
              }
              final controller = Get.find<DonationsController>();
              final bool success = await controller.quickDonation(
                amount: amountToDonate,
                isAnonymous: false,
              );

              if (success) {
                Get.back();
                showSuccessSnackBar(message: "تم التبرع بنجاح!");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'تبرع الآن',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPresetAmounts(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_presetAmounts.length, (index) {
        bool isSelected = _selectedAmountIndex == index;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: OutlinedButton(
              onPressed: () => _selectPresetAmount(index),
              style: OutlinedButton.styleFrom(
                foregroundColor: isSelected ? primaryColor : Colors.black87,
                backgroundColor: isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: isSelected ? primaryColor : Colors.grey.shade300,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Text(
                '${_presetAmounts[index]} ج.م',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).reversed.toList(),
    );
  }

  Widget _buildCustomAmountField(Color primaryColor) {
    return TextFormField(
      controller: _customAmountController,
      focusNode: _customAmountFocusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'مبلغ التبرع',
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('ج.م', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }

  Widget _buildInfoText(Color darkGreyColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(Icons.info_outline, color: darkGreyColor, size: 20),
        title: Text(
          'سيذهب تبرعك تلقائياً للحالات الأشد احتياجاً',
          style: TextStyle(color: darkGreyColor, fontSize: 13),
        ),
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 8,
        dense: true,
        minLeadingWidth: 0,
      ),
    );
  }

  Widget _buildPaymentMethods() {
    List<Widget> paymentIcons = [
      Image.asset('assets/images/master.png', height: 30, errorBuilder: (c, e, s) => const Text('Mastercard')),
      Image.asset('assets/images/visa.png', height: 25, errorBuilder: (c, e, s) => const Text('VISA')),
      Image.asset('assets/images/meeza.png', height: 25, errorBuilder: (c, e, s) => const Text('Mada')),
      ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          child: Image.asset('assets/images/apple.png', height: 25, errorBuilder: (c, e, s) => const Text(' Pay'))),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: paymentIcons
          .map((icon) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
                  child: icon,
                ),
              ))
          .toList(),
    );
  }
}
