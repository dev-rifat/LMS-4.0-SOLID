class ErrorModel {
  String? message;
  String? errorMessage;

  ErrorModel({this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errorMessage = json['error'];
  }
}

