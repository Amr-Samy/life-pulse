class OnBoard {
  int? id;
  String? description;
  String? text;
  String? imageUrl;

  OnBoard({this.id, this.description, this.text, this.imageUrl});

  OnBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    text = json['text'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['text'] = text;
    data['image_url'] = imageUrl;
    return data;
  }

  fromJson(e) {}
}
