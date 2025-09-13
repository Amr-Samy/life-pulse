class FAQs {
  String? status;
  List<Faq>? data;
  Paging? paging;

  FAQs({this.status, this.data, this.paging});

  FAQs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Faq>[];
      json['data'].forEach((v) {
        data!.add(Faq.fromJson(v));
      });
    }
    paging =
    json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class Faq {
  int? id;
  String? category;
  String? question;
  String? answer;

  Faq({this.id, this.category, this.question, this.answer});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['question'] = question;
    data['answer'] = answer;
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
