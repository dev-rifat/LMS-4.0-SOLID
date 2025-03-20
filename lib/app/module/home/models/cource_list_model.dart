class CourseListModel {
  List<Data>? data;

  CourseListModel({this.data});

  CourseListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? thumbnail;
  String? price;
  String? discountPrice;
  int? duration;
  int? categoryId;
  String? type;
  String? level;
  Data(
      {this.id,
        this.title,
        this.description,
        this.thumbnail,
        this.price,
        this.discountPrice,
        this.duration,
        this.categoryId,
        this.type,
        this.level});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    discountPrice = json['discount_price'];
    duration = json['duration'];
    categoryId = json['category_id'];
    type = json['type'];
    level = json['level'];
  }
}
