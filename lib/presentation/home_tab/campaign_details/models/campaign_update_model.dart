import '../../home/models/campaign_model.dart';

class CampaignUpdate {
  final int id;
  final String title;
  final String content;
  final String type;
  final String typeName;
  final bool isImportant;
  final List<String> images;
  final Creator creator;
  final DateTime createdAt;
  final DateTime updatedAt;

  CampaignUpdate({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.typeName,
    required this.isImportant,
    required this.images,
    required this.creator,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CampaignUpdate.fromJson(Map<String, dynamic> json) => CampaignUpdate(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    type: json["type"],
    typeName: json["type_name"],
    isImportant: json["is_important"],
    images: List<String>.from(json["images"].map((x) => x)),
    creator: Creator.fromJson(json["creator"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}