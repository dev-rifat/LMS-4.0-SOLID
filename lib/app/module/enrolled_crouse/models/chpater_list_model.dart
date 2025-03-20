class ChapterListModel {
  Data? data;

  ChapterListModel({this.data});

  ChapterListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  String? moduleId;
  String? number;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Video>? videos;
  List<File>? files;

  Data({
    this.id,
    this.moduleId,
    this.number,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.videos,
    this.files,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    number = json['number'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos!.add(Video.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((f) {
        files!.add(File.fromJson(f));
      });
    }
  }
}

class Video {
  int? id;
  String? lessonId;
  String? title;
  String? videoUrl;
  String? duration;
  String? status;
  String? thumbnail;
  String? createdAt;
  String? updatedAt;

  Video({
    this.id,
    this.lessonId,
    this.title,
    this.videoUrl,
    this.duration,
    this.status,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
  });

  Video.fromJson(Map<String, dynamic> json) {
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

class File {
  int? id;
  String? lessonId;
  String? title;
  String? file;

  File({this.id, this.lessonId, this.title, this.file});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonId = json['lesson_id'];
    title = json['title'];
    file = json['file'];
  }

}
