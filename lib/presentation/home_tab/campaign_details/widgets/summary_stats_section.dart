import 'package:flutter/material.dart';

class SummaryStatsSection extends StatelessWidget {
  const SummaryStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Fund Raised',
            value: '\$1M+',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            label: 'People donated',
            value: '30K+',
          ),
        ),
      ],
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
        crossAxisAlignment: CrossAxisAlignment.center,
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