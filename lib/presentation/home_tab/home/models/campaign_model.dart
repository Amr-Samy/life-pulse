import 'dart:convert';

import '../../campaign_details/models/campaign_update_model.dart';
CampaignsResponse campaignsResponseFromJson(String str) => CampaignsResponse.fromJson(json.decode(str));

class CampaignsResponse {
  final bool success;
  final List<Campaign> data;
  final Meta meta;

  CampaignsResponse({
    required this.success,
    required this.data,
    required this.meta,
  });

  factory CampaignsResponse.fromJson(Map<String, dynamic> json) => CampaignsResponse(
    success: json["success"],
    data: List<Campaign>.from(json["data"].map((x) => Campaign.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );


}

class Campaign {
  final int id;
  final String title;
  final String? description;
  final dynamic targetAmount;
  final dynamic currentAmount;
  final dynamic remainingAmount;
  final dynamic progressPercentage;
  final bool isActive;
  final bool isPriority;
  final List<String>? images;
  final Creator creator;
  final dynamic donationsCount;
  final int? updatesCount;
  final CampaignUpdate? latestUpdate;
  final bool isFavorited;
  final DateTime createdAt;
  final DateTime updatedAt;
  DateTime? endTime;

  Campaign({
    required this.id,
    required this.title,
    this.description,
    required this.targetAmount,
    required this.currentAmount,
    required this.remainingAmount,
    required this.progressPercentage,
    required this.isActive,
    required this.isPriority,
    this.images,
    required this.creator,
    required this.donationsCount,
    this.updatesCount,
    this.latestUpdate,
    required this.isFavorited,
    required this.createdAt,
    required this.updatedAt,
    this.endTime,
  });

  String? get firstImage => (images != null && images!.isNotEmpty) ? images!.first : null;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    targetAmount: json["target_amount"],
    currentAmount: json["current_amount"],
    remainingAmount: json["remaining_amount"],
    progressPercentage: json["progress_percentage"],
    isActive: json["is_active"],
    isPriority: json["is_priority"],
    images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    creator: Creator.fromJson(json["creator"]),
    donationsCount: json["donations_count"],
        updatesCount: json["updates_count"],
        latestUpdate: json["latest_update"] == null
            ? null
            : CampaignUpdate.fromJson(json["latest_update"]),
    isFavorited: json["is_favorited"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    endTime: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),

  );

  Campaign copyWith({
    int? id,
    String? title,
    String? description,
    dynamic targetAmount,
    dynamic currentAmount,
    dynamic remainingAmount,
    dynamic progressPercentage,
    bool? isActive,
    bool? isPriority,
    List<String>? images,
    Creator? creator,
    dynamic donationsCount,
    bool? isFavorited,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? endDate,
    int? updatesCount,
    CampaignUpdate? latestUpdate,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      isActive: isActive ?? this.isActive,
      isPriority: isPriority ?? this.isPriority,
      images: images ?? this.images,
      creator: creator ?? this.creator,
      donationsCount: donationsCount ?? this.donationsCount,
      updatesCount: updatesCount ?? this.updatesCount,
      latestUpdate: latestUpdate ?? this.latestUpdate,
      isFavorited: isFavorited ?? this.isFavorited,
      endTime: endDate ?? endTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}


class Creator {
  final int id;
  final String name;
  final String? profileImage;

  Creator({
    required this.id,
    required this.name,
    this.profileImage,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    id: json["id"],
    name: json["name"],
    profileImage: json["profile_image"],
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