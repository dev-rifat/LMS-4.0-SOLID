class MyCourseModel {
  List<Enrollments>? enrollments;

  MyCourseModel({this.enrollments});

  MyCourseModel.fromJson(Map<String, dynamic> json) {
    if (json['enrollments'] != null) {
      enrollments = <Enrollments>[];
      json['enrollments'].forEach((v) {
        enrollments!.add(new Enrollments.fromJson(v));
      });
    }
  }
}

class Enrollments {
  int? userId;
  int? courseId;
  String? price;
  String? enrollmentDate;
  String? expire;
  String? status;
  String? enrollmentStatus;
  Course? course;

  Enrollments(
      {this.userId,
        this.courseId,
        this.price,
        this.enrollmentDate,
        this.expire,
        this.status,
        this.enrollmentStatus,
        this.course});

  Enrollments.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    courseId = json['course_id'];
    price = json['price'];
    enrollmentDate = json['enrollment_date'];
    expire = json['expire'];
    status = json['status'];
    enrollmentStatus = json['enrollment_status'];
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
  }
}

class Course {
  int? id;
  String? title;
  String? thumbnail;
  int? duration;
  String? level;
  String? type;

  Course(
      {this.id,
        this.title,
        this.thumbnail,
        this.duration,
        this.level,
        this.type});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    level = json['level'];
    type = json['type'];
  }

}
