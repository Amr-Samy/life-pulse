import 'package:life_pulse/presentation/resources/strings_manager.dart';

class ReceiptModel {
  String? status;
  PaymentTransactionDetails? paymentTransactionDetails;

  ReceiptModel({this.status, this.paymentTransactionDetails});

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paymentTransactionDetails = json['payment_transaction_details'] != null
        ? PaymentTransactionDetails.fromJson(
        json['payment_transaction_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (paymentTransactionDetails != null) {
      data['payment_transaction_details'] =
          paymentTransactionDetails!.toJson();
    }
    return data;
  }
}

class PaymentTransactionDetails {
  int? id;
  String? transactionId;
  double? paidAmount;
  String? paymentMethod;
  String? status;
  String? createdAt;
  String? barcodeUrl;
  Course? course;
  Student? student;

  PaymentTransactionDetails(
      {this.id,
        this.transactionId,
        this.paidAmount,
        this.paymentMethod,
        this.status,
        this.createdAt,
        this.barcodeUrl,
        this.course,
        this.student});

  PaymentTransactionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    paidAmount = json['paid_amount'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    createdAt = json['created_at'];
    barcodeUrl = AppStrings.baseUrl + json['barcode_url'];
    course =
    json['course'] != null ? Course.fromJson(json['course']) : null;
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['paid_amount'] = paidAmount;
    data['payment_method'] = paymentMethod;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['barcode_url'] = barcodeUrl;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    if (student != null) {
      data['student'] = student!.toJson();
    }
    return data;
  }
}

class Course {
  int? id;
  String? name;
  Category? category;

  Course({this.id, this.name, this.category});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  String? name;

  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Student {
  int? id;
  String? email;
  String? fullName;
  String? phone;

  Student({this.id, this.email, this.fullName, this.phone});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['full_name'] = fullName;
    data['phone'] = phone;
    return data;
  }
}
