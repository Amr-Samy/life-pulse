import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Cairo',
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showDonationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const DonationBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نموذج التبرع'),
        backgroundColor: const Color(0xFF16a085),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showDonationSheet(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF16a085),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text('افتح شاشة التبرع'),
        ),
      ),
    );
  }
}

class DonationBottomSheet extends StatefulWidget {
  const DonationBottomSheet({super.key});

  @override
  State<DonationBottomSheet> createState() => _DonationBottomSheetState();
}

class _DonationBottomSheetState extends State<DonationBottomSheet> {
  final List<bool> _categorySelection = [true, false, false, false];

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
    const Color lightGreyColor = Color(0xFFF0F0F0);
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

          // Donate Now
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
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

  Widget _buildCategorySelector(Color primaryColor) {
    return SizedBox(
      height: 40,
      child: ToggleButtons(
        isSelected: _categorySelection,
        onPressed: (index) {
          setState(() {
            for (int i = 0; i < _categorySelection.length; i++) {
              _categorySelection[i] = i == index;
            }
          });
        },
        borderRadius: BorderRadius.circular(8),
        selectedColor: Colors.white,
        fillColor: primaryColor,
        color: primaryColor,
        borderColor: primaryColor,
        selectedBorderColor: primaryColor,
        constraints: BoxConstraints(minWidth: (MediaQuery.of(context).size.width - 40) / 4, minHeight: 40),
        children: const [
          Text('تبرع عام'),
          Text('أورام'),
          Text('أطفال'),
          Text('كبار سن'),
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
        color:  Colors.white,
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
      Image.asset('assets/apple_pay.png', height: 25, errorBuilder: (c, e, s) => const Text(' Pay')),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: paymentIcons.map((icon) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300)
          ),
          child: icon,
        ),
      )).toList(),
    );
  }
}