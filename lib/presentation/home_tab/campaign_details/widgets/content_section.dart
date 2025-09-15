import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  final String title;
  final String content;
  final String? imageUrl;

  const ContentSection({
    super.key,
    required this.title,
    required this.content,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        if (imageUrl != null) ...[
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(imageUrl!, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ]
      ],
    );
  }
}