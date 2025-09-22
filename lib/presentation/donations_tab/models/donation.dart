import 'dart:convert';
import '../../home_tab/home/models/campaign_model.dart';

DonationsResponse donationsResponseFromJson(String str) =>
    DonationsResponse.fromJson(json.decode(str));

Donation donationFromJson(String str) => Donation.fromJson(json.decode(str));

class DonationsResponse {
  final bool success;
  final List<Donation> data;
  final Meta meta;

  DonationsResponse({
    required this.success,
    required this.data,
    required this.meta,
  });

  factory DonationsResponse.fromJson(Map<String, dynamic> json) =>
      DonationsResponse(
        success: json["success"],
        data: List<Donation>.from(json["data"].map((x) => Donation.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );
}

class Donation {
  final int id;
  final dynamic amount;
  final bool isAnonymous;
  final String status;
  final String? paymentMethod;
  final String? transactionId;
  //final Creator? user;
  final Campaign campaign;
  final DateTime createdAt;
  final DateTime updatedAt;

  Donation({
    required this.id,
    required this.amount,
    required this.isAnonymous,
    required this.status,
    this.paymentMethod,
    this.transactionId,
    //required this.user,
    required this.campaign,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
    id: json["id"],
    amount: json["amount"],
    isAnonymous: json["is_anonymous"],
    status: json["status"],
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
    //user: Creator.fromJson(json["user"]),
    campaign: Campaign.fromJson(json["campaign"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
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