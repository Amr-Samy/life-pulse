import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction_model.dart';

class TransactionListItemWidget extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionListItemWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.description ?? transaction.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('d MMM yyyy').format(transaction.createdAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                transaction.status == 'completed' ? Icons.verified_outlined : Icons.error_outline,
                color: transaction.status == 'completed' ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                '${transaction.sign}\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}