import 'package:flutter/material.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';

class Partner {
  final String name;
  final String logo;

  const Partner({required this.name, required this.logo});
}

final List<Partner> allPartners = [
  const Partner(name: 'الشريك الاستراتيجي', logo: 'assets/images/un.png'),
  const Partner(name: 'الشريك التكنولوجي', logo: 'assets/images/cisco.png'),
  const Partner(name: 'الشريك التكنولوجي', logo: 'assets/images/huawai.png'),
  const Partner(name: 'الشريك التكنولوجي', logo: 'assets/images/it.png'),
  const Partner(name: '', logo: 'assets/images/orange.png'),
  const Partner(name: '', logo: 'assets/images/voda.png'),
  const Partner(name: '', logo: 'assets/images/we.png'),
];

class SuccessPartnersScreen extends StatelessWidget {
  const SuccessPartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainPartner = allPartners.first;
    final row1 = allPartners.sublist(1, 4); // 3 elements
    final row2 = allPartners.sublist(4, 7); // 3 elements

    final List<Color> bubbleColors = [
      Colors.green.shade200,
      Colors.green.shade400,
      const Color(0xFF1DB954),
      Colors.green.shade700,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          AppStrings.successPartners.tr,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.1),
        leading: const BackButton(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // main partner in center
            _buildPartnerBubble(
              size: 200,
              color: bubbleColors[0],
              partner: mainPartner,
            ),
            const SizedBox(height: 40),

            // first row with 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(row1.length, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildPartnerBubble(
                    size: 100,
                    color: bubbleColors[(i + 1) % bubbleColors.length],
                    partner: row1[i],
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),

            // second row with 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(row2.length, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildPartnerBubble(
                    size: 100,
                    color: Colors.white,
                    partner: row2[i],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerBubble({
    required double size,
    required Color color,
    required Partner partner,
  }) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Center(
            child: Image.asset(
              partner.logo,
              width: size * 0.7,
              height: size * 0.7,
              fit: BoxFit.contain,
            ),
          ),
        ),
        if (partner.name.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            partner.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ],
    );
  }
}
