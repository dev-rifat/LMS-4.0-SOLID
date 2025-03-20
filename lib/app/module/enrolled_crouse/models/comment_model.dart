class CommentModel {
  List<Comments>? comments;

  CommentModel({this.comments});

  CommentModel.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

}

class Comments {
  int? id;
  int? courseId;
  String? comment;
  int? userId;
  List<Replies>? replies;

  Comments({this.id, this.courseId, this.comment, this.userId, this.replies});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    comment = json['comment'];
    userId = json['user_id'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

}

class Replies {
  int? id;
  int? courseCommentId;
  String? reply;

  Replies({this.id, this.courseCommentId, this.reply});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseCommentId = json['course_comment_id'];
    reply = json['reply'];
  }
}
