class SearchModel {
  List<Courses>? courses;

  SearchModel({this.courses});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }
}

class Courses {
  int? id;
  String? title;
  String? description;
  String? thumbnail;
  int? duration;
  String? price;
  String? discountPrice;
  int? categoryId;
  String? type;
  String? level;

  Courses(
      {this.id,
        this.title,
        this.description,
        this.thumbnail,
        this.duration,
        this.discountPrice,
        this.price,
        this.categoryId,
        this.type,
        this.level});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    price = json['price'];
    discountPrice = json['discount_price'];
    categoryId = json['category_id'];
    type = json['type'];
    level = json['level'];
  }
}
