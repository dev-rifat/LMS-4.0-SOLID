class UserCouponModel {
  CouponUser? couponUser;

  UserCouponModel({this.couponUser});

  UserCouponModel.fromJson(Map<String, dynamic> json) {
    couponUser = json['couponUser'] != null
        ? new CouponUser.fromJson(json['couponUser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.couponUser != null) {
      data['couponUser'] = this.couponUser!.toJson();
    }
    return data;
  }
}

class CouponUser {
  int? id;
  String? userId;
  String? title;
  String? expire;
  String? status;
  String? percentage;
  String? createdAt;
  String? updatedAt;

  CouponUser(
      {this.id,
        this.userId,
        this.title,
        this.expire,
        this.status,
        this.percentage,
        this.createdAt,
        this.updatedAt});

  CouponUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    expire = json['expire'];
    status = json['status'];
    percentage = json['percentage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['expire'] = this.expire;
    data['status'] = this.status;
    data['percentage'] = this.percentage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
