class ModuleModel {
  List<Modules>? modules;

  ModuleModel({this.modules});

  ModuleModel.fromJson(Map<String, dynamic> json) {
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(new Modules.fromJson(v));
      });
    }
  }
}

class Modules {
  int? id;
  int? courseId;
  String? thumbnail;
  String? file;
  String? title;
  String? duration;
  String? description;

  Modules(
      {this.id,
        this.courseId,
        this.thumbnail,
        this.file,
        this.title,
        this.duration,
        this.description});

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    thumbnail = json['thumbnail'];
    file = json['file'];
    title = json['title'];
    duration = json['duration'];
    description = json['description'];
  }
}
