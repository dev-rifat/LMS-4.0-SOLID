class ChangePasswordModel {
  String? message;
  Map<String, dynamic>? errors;

  ChangePasswordModel({this.errors, this.message});

  // Factory constructor to create the model from JSON
  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      errors: json['errors'] as Map<String, dynamic>?,
      message: json['message'] != null ? json['message'] as String : null,
    );
  }

  // Method to retrieve error messages for a specific field
  List<String>? getErrorMessages(String field) {
    if (errors != null && errors![field] != null) {
      return List<String>.from(errors![field]);
    }
    return null;
  }
}
