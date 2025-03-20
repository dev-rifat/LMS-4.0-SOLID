class CategoryWithProduct {
  List<Data>? data;

  CategoryWithProduct({this.data});

  CategoryWithProduct.fromJson(Map<String, dynamic> json) {
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
  int? categoryId;
  String? description;
  String? thumbnail;
  String? price;
  String? discountPrice;
  int? duration;
  String? type;
  String? level;

  Data(
      {this.id,
        this.title,
        this.categoryId,
        this.description,
        this.thumbnail,
        this.price,
        this.discountPrice,
        this.duration,
        this.type,
        this.level});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    discountPrice = json['discount_price'];
    duration = json['duration'];
    type = json['type'];
    level = json['level'];
  }
}
