class ChapterDetailsModel {
  Data? data;

  ChapterDetailsModel({this.data});

  ChapterDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  int? moduleId;
  int? number;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Videos>? videos;
  List<Files>? files;
  Module? module;

  Data(
      {this.id,
        this.moduleId,
        this.number,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.videos,
        this.files,
        this.module});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    number = json['number'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    module =
    json['module'] != null ? new Module.fromJson(json['module']) : null;
  }
}

class Videos {
  int? id;
  int? lessonId;
  String? title;
  String? videoUrl;
  int? duration;
  int? status;
  String? thumbnail;
  String? createdAt;
  String? updatedAt;

  Videos(
      {this.id,
        this.lessonId,
        this.title,
        this.videoUrl,
        this.duration,
        this.status,
        this.thumbnail,
        this.createdAt,
        this.updatedAt});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonId = json['lesson_id'];
    title = json['title'];
    videoUrl = json['video_url'];
    duration = json['duration'];
    status = json['status'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Files {
  int? id;
  int? lessonId;
  String? title;
  String? file;

  Files({this.id, this.lessonId, this.title, this.file});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonId = json['lesson_id'];
    title = json['title'];
    file = json['file'];
  }
}

class Module {
  int? id;
  String? description;

  Module({this.id, this.description});

  Module.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }
}
