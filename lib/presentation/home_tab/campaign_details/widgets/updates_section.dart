import 'package:flutter/material.dart';

class UpdatesSection extends StatelessWidget {
  const UpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Updates',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _UpdateCard(
          updateText:
          'Thanks to your incredible support, we have successfully distributed over 500 emergency supply kits to families in the northern regions. Your donations are making a real difference!',
          imageUrl: 'https://i.imgur.com/z83z2yM.jpeg',
          timestamp: 'September 14, 2025',
        ),
        const SizedBox(height: 12),
        _UpdateCard(
          updateText:
          'Today, our team on the ground started the construction of a new temporary shelter. We are grateful for the local volunteers who have joined our cause.',
          timestamp: 'September 12, 2025',
        ),
      ],
    );
  }
}

class _UpdateCard extends StatelessWidget {
  final String updateText;
  final String timestamp;
  final String? imageUrl;

  const _UpdateCard({
    required this.updateText,
    required this.timestamp,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl!,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            updateText,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Posted on $timestamp',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}