

class CouponListModel {
  List<Coupons>? coupons;

  CouponListModel({this.coupons});

  CouponListModel.fromJson(Map<String, dynamic> json) {
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(new Coupons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  int? id;
  String? title;
  String? thumbnail;
  String? expire;
  String? status;
  String? percentage;
  String? createdAt;
  String? updatedAt;

  Coupons(
      {this.id,
        this.title,
        this.thumbnail,
        this.expire,
        this.status,
        this.percentage,
        this.createdAt,
        this.updatedAt});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    expire = json['expire'];
    status = json['status'];
    percentage = json['percentage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['expire'] = this.expire;
    data['status'] = this.status;
    data['percentage'] = this.percentage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
