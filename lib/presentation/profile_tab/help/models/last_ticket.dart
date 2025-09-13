class LastTicketResponse {
  String? status;
  Data? data;

  LastTicketResponse({this.status, this.data});

  LastTicketResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Ticket>? tickets;
  Paging? paging;

  Data({this.tickets, this.paging});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ticket'] != null) {
      tickets = <Ticket>[];
      json['ticket'].forEach((v) {
        tickets!.add(Ticket.fromJson(v));
      });
    }
    paging =
    json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tickets != null) {
      data['ticket'] = tickets!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class Ticket {
  int? id;
  String? content;
  String? createdBy;
  String? createdAt;

  Ticket({this.content, this.createdBy, this.createdAt});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
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
