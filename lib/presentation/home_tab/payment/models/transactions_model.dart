import 'package:life_pulse/presentation/resources/strings_manager.dart';

class TransactionsModel {
  String? status;
  Data? data;
  Paging? paging;

  TransactionsModel({this.status, this.data, this.paging});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    paging =
    json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class Data {
  List<Transactions>? transactions;

  Data({this.transactions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  int? id;
  String? status;
  Course? course;

  Transactions({this.id, this.status, this.course});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    course =
    json['course'] != null ? Course.fromJson(json['course']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class Course {
  int? id;
  String? name;
  String? imageUrl;
  Course({this.id, this.name, this.imageUrl});
  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = AppStrings.baseUrl+json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
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
