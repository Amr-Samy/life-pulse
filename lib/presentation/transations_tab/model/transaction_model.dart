import 'package:flutter/material.dart';
import 'dart:convert';

TransactionsResponse transactionsResponseFromJson(String str) =>
    TransactionsResponse.fromJson(json.decode(str));

class TransactionsResponse {
  final bool success;
  final List<TransactionModel> data;
  final Meta meta;

  TransactionsResponse({
    required this.success,
    required this.data,
    required this.meta,
  });

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) =>
      TransactionsResponse(
        success: json["success"],
        data: List<TransactionModel>.from(
            json["data"].map((x) => TransactionModel.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );
}

class TransactionModel {
  final int id;
  final dynamic amount;
  final String type;
  final String status;
  final String? transactionId;
  final String? description;
  final String? reference;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.status,
    this.transactionId,
    this.description,
    this.reference,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        amount: double.tryParse(json["amount"].toString()) ?? 0.0,
        type: json["type"],
        status: json["status"],
        transactionId: json["transaction_id"],
         description: json["description"],
        reference: json["reference"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  String get title =>
      type.toLowerCase() == 'charge' ? 'Wallet Top Up' : 'Donation';
  Color get color =>
      type.toLowerCase() == 'credit' ? Colors.green : Colors.red;
  String get sign => type.toLowerCase() == 'credit' ? '+' : '-';
}

class Meta {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  Meta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
      );
}