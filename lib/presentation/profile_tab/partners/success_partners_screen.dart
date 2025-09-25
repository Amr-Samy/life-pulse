import 'package:flutter/material.dart';
import 'dart:math';

class Partner {
  final String name;
  final IconData logo;

  const Partner({required this.name, required this.logo});
}

final List<Partner> allPartners = [
  const Partner(name: 'Innovate Corp', logo: Icons.computer),
  const Partner(name: 'EcoBuild', logo: Icons.eco),
  const Partner(name: 'HealthFirst', logo: Icons.local_hospital),
  const Partner(name: 'Quantum Fintech', logo: Icons.insights),
  const Partner(name: 'Ministry of Education', logo: Icons.school),
  const Partner(name: 'Health Service', logo: Icons.health_and_safety),
  const Partner(name: 'UNICEF', logo: Icons.child_friendly),
  const Partner(name: 'World Health Org.', logo: Icons.public),
  const Partner(name: 'Food Program', logo: Icons.restaurant),
  const Partner(name: 'EPA', logo: Icons.landscape),
];

class SuccessPartnersScreen extends StatefulWidget {
  const SuccessPartnersScreen({super.key});

  @override
  State<SuccessPartnersScreen> createState() => _SuccessPartnersScreenState();
}

class _SuccessPartnersScreenState extends State<SuccessPartnersScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // positions
  final List<Map<String, double>> bubbleProperties = [
    {'size': 120, 'top': 40, 'left': 20},
    {'size': 90, 'top': 80, 'right': 30},
    {'size': 110, 'top': 180, 'left': 100},
    {'size': 80, 'top': 200, 'right': 110},
    {'size': 130, 'top': 300, 'left': 25},
    {'size': 100, 'top': 320, 'right': 50},
    {'size': 85, 'top': 450, 'left': 150},
    {'size': 115, 'top': 480, 'right': 20},
    {'size': 95, 'top': 580, 'left': 40},
    {'size': 105, 'top': 620, 'right': 140},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> bubbleColors = [
      Colors.green.shade200,
      Colors.green.shade400,
      const Color(0xFF1DB954),
      Colors.green.shade700,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Our Partners', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.1),
        leading: const BackButton(color: Colors.black),
      ),
      body: Stack(
        children: List.generate(allPartners.length, (index) {
          final properties = bubbleProperties[index % bubbleProperties.length];
          final color = bubbleColors[index % bubbleColors.length];
          final partner = allPartners[index];

          return Positioned(
            top: properties['top'],
            left: properties['left'],
            right: properties['right'],
            child: FadeTransition(
              opacity: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
              child: ScaleTransition(
                scale: CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
                child: _buildPartnerBubble(
                  size: properties['size']!,
                  color: color,
                  partner: partner,
                ),
              ),
            ),
          );
        }),
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
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Icon(partner.logo, color: Colors.white, size: size * 0.5),
        ),
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
    );
  }
}