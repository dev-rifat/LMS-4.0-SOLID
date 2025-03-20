class LessonModel {
  List<Lessons>? lessons;

  LessonModel({this.lessons});

  LessonModel.fromJson(Map<String, dynamic> json) {
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(new Lessons.fromJson(v));
      });
    }
  }

}

class Lessons {
  int? id;
  int? moduleId;
  int? number;
  String? name;

  Lessons({this.id, this.moduleId, this.number, this.name});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    number = json['number'];
    name = json['name'];
  }
}
