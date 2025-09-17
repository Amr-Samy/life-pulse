import 'package:flutter/material.dart';


enum TransactionType { credit, debit }

class TransactionModel {
  final String title;
  final DateTime date;
  final double amount;
  final TransactionType type;

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
  });


  Color get color =>
      type == TransactionType.credit ? Colors.green : Colors.red;


  String get sign => type == TransactionType.credit ? '+' : '-';
}