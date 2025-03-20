class NotificationModel {
  String? status;
  List<Notifications>? notifications;

  NotificationModel({this.status, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

}

class Notifications {
  int? id;
  int? courseId;
  String? type;
  String? comment;


  Notifications(
      {this.id,
        this.courseId,
        this.type,
        this.comment});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    type = json['type'];
    comment = json['comment'];
  }
}
