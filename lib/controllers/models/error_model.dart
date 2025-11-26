class ErrorModel {
  String? status;
  String? message;

  ErrorModel({this.status, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status_code'] ?? json['status'].toString();
    message = json['message'] ?? json['errorMsg'] ?? json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}