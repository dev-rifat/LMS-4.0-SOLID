class CourseDetailsModel {
  Data? data;
  bool? isEnrollerd;

  CourseDetailsModel({this.data, this.isEnrollerd});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    isEnrollerd = json['isEnrollerd'];
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  int? totalModule;
  String? thumbnail;
  String? price;
  String? discountPrice;
  int? duration;
  String? type;
  String? level;
  String? status;

  Data(
      {this.id,
        this.title,
        this.description,
        this.totalModule,
        this.thumbnail,
        this.price,
        this.discountPrice,
        this.duration,
        this.type,
        this.level,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    totalModule = json['total_module'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    discountPrice = json['discount_price'];
    duration = json['duration'];
    type = json['type'];
    level = json['level'];
    status = json['status'];
  }

}
