class AddPaypalPayment {
  String? message;
  Enrollment? enrollment;

  AddPaypalPayment({this.message, this.enrollment});

  AddPaypalPayment.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    enrollment = json['enrollment'] != null
        ? new Enrollment.fromJson(json['enrollment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.enrollment != null) {
      data['enrollment'] = this.enrollment!.toJson();
    }
    return data;
  }
}

class Enrollment {
  String? userEmail;
  String? firstName;
  String? lastName;
  String? payerId;
  String? paymentId;
  int? price;
  String? currency;
  String? status;
  String? courseId;
  int? userId;
  String? courseTitle;
  String? expire;
  String? enrollmentDate;
  String? updatedAt;
  String? createdAt;
  int? id;

  Enrollment(
      {this.userEmail,
        this.firstName,
        this.lastName,
        this.payerId,
        this.paymentId,
        this.price,
        this.currency,
        this.status,
        this.courseId,
        this.userId,
        this.courseTitle,
        this.expire,
        this.enrollmentDate,
        this.updatedAt,
        this.createdAt,
        this.id});

  Enrollment.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    payerId = json['payer_id'];
    paymentId = json['payment_id'];
    price = json['price'];
    currency = json['currency'];
    status = json['status'];
    courseId = json['course_id'];
    userId = json['user_id'];
    courseTitle = json['course_title'];
    expire = json['expire'];
    enrollmentDate = json['enrollment_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.userEmail;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['payer_id'] = this.payerId;
    data['payment_id'] = this.paymentId;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['course_title'] = this.courseTitle;
    data['expire'] = this.expire;
    data['enrollment_date'] = this.enrollmentDate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
