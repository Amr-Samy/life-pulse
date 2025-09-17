import 'package:flutter/material.dart';

class Partner {
  final String name;
  final String description;
  final String logoUrl;
  final Color logoBgColor;

  const Partner({
    required this.name,
    required this.description,
    required this.logoUrl,
    this.logoBgColor = Colors.black,
  });
}

final List<Partner> privatePartners = [
  const Partner(name: 'Innovate Corp', description: 'Technology & AI Solutions', logoUrl: 'https://i.imgur.com/example-logo-1.png', logoBgColor: Color(0xFF2d3436)),
  const Partner(name: 'EcoBuild Ventures', description: 'Sustainable Construction', logoUrl: 'https://i.imgur.com/example-logo-2.png', logoBgColor: Color(0xFF00b894)),
  const Partner(name: 'HealthFirst Pharma', description: 'Medical Research & Development', logoUrl: 'https://i.imgur.com/example-logo-3.png', logoBgColor: Color(0xFF0984e3)),
  const Partner(name: 'Quantum Fintech', description: 'Financial Services Partner', logoUrl: 'https://i.imgur.com/example-logo-4.png', logoBgColor: Color(0xFFd63031)),
];

final List<Partner> governmentPartners = [
  const Partner(name: 'Ministry of Education', description: 'Educational Program Partner', logoUrl: 'https://i.imgur.com/example-gov-1.png', logoBgColor: Color(0xFF6c5ce7)),
  const Partner(name: 'National Health Service', description: 'Public Health Initiatives', logoUrl: 'https://i.imgur.com/example-gov-2.png', logoBgColor: Color(0xFF00cec9)),
  const Partner(name: 'Environmental Protection Agency', description: 'Conservation & Sustainability', logoUrl: 'https://i.imgur.com/example-gov-3.png', logoBgColor: Color(0xFF2d3436)),
];

final List<Partner> globalPartners = [
  const Partner(name: 'World Health Org.', description: 'Global Health & Safety', logoUrl: 'https://i.imgur.com/example-global-1.png', logoBgColor: Color(0xFF0984e3)),
  const Partner(name: 'UNICEF', description: 'Children\'s Rights & Aid', logoUrl: 'https://i.imgur.com/example-global-2.png', logoBgColor: Color(0xFF2d3436)),
  const Partner(name: 'Global Food Program', description: 'Humanitarian Food Assistance', logoUrl: 'https://i.imgur.com/example-global-3.png', logoBgColor: Color(0xFF6c5ce7)),
];


class SuccessPartnersScreen extends StatefulWidget {
  const SuccessPartnersScreen({super.key});

  @override
  State<SuccessPartnersScreen> createState() => _SuccessPartnersScreenState();
}

class _SuccessPartnersScreenState extends State<SuccessPartnersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1DB954);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Success Partners', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.1),
        leading: const BackButton(color: Colors.black),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey[600],
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          tabs: const [
            Tab(text: 'Private Sector'),
            Tab(text: 'Government'),
            Tab(text: 'Global Orgs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPartnerList(privatePartners),
          _buildPartnerList(governmentPartners),
          _buildPartnerList(globalPartners),
        ],
      ),
    );
  }

  Widget _buildPartnerList(List<Partner> partners) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: partners.length,
      itemBuilder: (context, index) {
        return _buildPartnerCard(partners[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }

  Widget _buildPartnerCard(Partner partner) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: partner.logoBgColor,
            child: const Icon(Icons.location_city, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  partner.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  partner.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}