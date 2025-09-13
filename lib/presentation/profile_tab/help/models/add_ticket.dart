class AddTicketResponse {
  String? status;
  int? id;
  String? ticketNumber;

  AddTicketResponse({this.status, this.id, this.ticketNumber});

  AddTicketResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    ticketNumber = json['ticket_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['id'] = id;
    data['ticket_number'] = ticketNumber;
    return data;
  }
}

class ReplyTicketResponse {
  String? status;
  int? id;
  int? ticketId;

  ReplyTicketResponse({this.status, this.id, this.ticketId});

  ReplyTicketResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    ticketId = json['ticket_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['id'] = id;
    data['ticket_id'] = ticketId;
    return data;
  }
}
