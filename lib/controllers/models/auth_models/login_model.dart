class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  UserDetails? userDetails;
  String? token;

  Data({this.userDetails, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userDetails = json['user'] != null ? UserDetails.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDetails != null) {
      data['user'] = userDetails!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserDetails {
  int? id;
  int? clubId;
  int? roleId;
  String? name;
  String? email;
  String? profileImage;
  String? emailVerifiedAt;
  String? countryCode;
  String? phone;
  String? gender;
  String? timezone;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  UserDetails(
      {this.id,
        this.clubId,
        this.roleId,
        this.name,
        this.email,
        this.profileImage,
        this.emailVerifiedAt,
        this.countryCode,
        this.phone,
        this.gender,
        this.timezone,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    roleId = json['role_id'];
    name = json['name'].toString();
    email = json['email'].toString();
    profileImage = json['profile_image'].toString();
    emailVerifiedAt = json['email_verified_at'].toString();
    countryCode = json['country_code'].toString();
    phone = json['phone'].toString();
    gender = json['gender'].toString();
    timezone = json['timezone'].toString();
    isActive = json['is_active'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['club_id'] = clubId;
    data['role_id'] = roleId;
    data['name'] = name;
    data['email'] = email;
    data['profile_image'] = profileImage;
    data['email_verified_at'] = emailVerifiedAt;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['gender'] = gender;
    data['timezone'] = timezone;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
