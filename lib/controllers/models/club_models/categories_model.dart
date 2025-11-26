import 'paricipants_model.dart';

class CategoriesModel {
  bool? status;
  String? message;
  Data? data;

  CategoriesModel({this.status, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Category>? category;

  Data({this.category});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? eventId;
  String? eventName;
  int? clubId;
  String? clubName;
  int? categoryId;
  String? categoryName;
  String? orderNo;
  String? status;
  List<AgeGroups>? ageGroups;

  Category(
      {this.eventId,
        this.eventName,
        this.clubId,
        this.clubName,
        this.categoryId,
        this.categoryName,
        this.orderNo,
        this.status,
        this.ageGroups});

  Category.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventName = json['event_name'].toString();
    clubId = json['club_id'];
    clubName = json['club_name'].toString();
    categoryId = json['category_id'];
    categoryName = json['category_name'].toString();
    orderNo = json['order_no'].toString();
    status = json['status'].toString();
    if (json['age_groups'] != null) {
      ageGroups = <AgeGroups>[];
      json['age_groups'].forEach((v) {
        ageGroups!.add(AgeGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['event_name'] = eventName;
    data['club_id'] = clubId;
    data['club_name'] = clubName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['order_no'] = orderNo;
    data['status'] = status;
    if (ageGroups != null) {
      data['age_groups'] = ageGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}