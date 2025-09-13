class LanguagesModel {
  String? status;
  List<Language>? languages;
  Paging? paging;

  LanguagesModel({this.status, this.languages, this.paging});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      languages = <Language>[];
      json['data'].forEach((v) {
        languages!.add(Language.fromJson(v));
      });
    }
    paging =
    json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.languages != null) {
      data['data'] = this.languages!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class Language {
  int? id;
  String? name;
  String? code;

  Language({this.id, this.name, this.code});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class Paging {
  int? total;
  int? page;
  int? pages;
  int? prev;
  int? next;

  Paging({this.total, this.page, this.pages, this.prev, this.next});

  Paging.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    pages = json['pages'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['pages'] = pages;
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}