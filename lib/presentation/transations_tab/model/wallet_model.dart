import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

class Wallet {
  final dynamic balance;
  final dynamic totalDonations;
  final int donationsCount;

  Wallet({
    required this.balance,
    required this.totalDonations,
    required this.donationsCount,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    balance: json["balance"],
    totalDonations: json["total_donations"],
    donationsCount: json["donations_count"],
  );
}