import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/strings_manager.dart';
import '../../home/models/campaign_model.dart';

class SummaryStatsSection extends StatelessWidget {
  final Campaign campaign;
  const SummaryStatsSection({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _StatCard(
            label: AppStrings.fundRaisedFrom.tr,
            value: '${campaign.currentAmount} ج.م',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            label: AppStrings.peopleDonated.tr,
            value: '${campaign.donationsCount}',
          ),
        ),
      ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.teal[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
        ],
      ),
    );
  }
}