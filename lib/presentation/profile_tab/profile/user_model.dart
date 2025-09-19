import 'dart:convert';
ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

class ProfileResponse {
  final bool success;
  final UserModel data;

  ProfileResponse({
    required this.success,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    success: json["success"],
    data: UserModel.fromJson(json["data"]),
  );
}

class UserModel {
  final int id;
  final String name;
  final String mobile;
  final double? walletBalance;
  final String? profileImage;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.mobile,
    required this.walletBalance,
    required this.profileImage,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    walletBalance: (json["wallet_balance"] as num).toDouble(),
    profileImage: json["profile_image"],
    isAdmin: json["is_admin"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}