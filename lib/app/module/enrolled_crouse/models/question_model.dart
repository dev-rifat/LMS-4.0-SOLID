class QuestionModel {
  Exam? exam;
  Attempts? attempts;

  QuestionModel({this.exam, this.attempts});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    exam = json['exam'] != null ? new Exam.fromJson(json['exam']) : null;
    attempts = json['attempts'] != null
        ? new Attempts.fromJson(json['attempts'])
        : null;
  }

}

class Exam {
  int? id;
  int? moduleId;
  String? title;
  String? description;
  int? duration;
  int? status;
  List<Questions>? questions;

  Exam(
      {this.id,
        this.moduleId,
        this.title,
        this.description,
        this.duration,
        this.status,
        this.questions});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    status = json['status'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }
}

class Questions {
  int? id;
  int? examId;
  String? questionText;
  String? questionImage;
  List<Options>? options;

  Questions(
      {this.id,
        this.examId,
        this.questionText,
        this.questionImage,
        this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    questionText = json['question_text'];
    questionImage = json['question_image'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }
}

class Options {
  int? id;
  int? questionId;
  String? optionText;
  int? isCorrect;

  Options({this.id, this.questionId, this.optionText, this.isCorrect});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    optionText = json['option_text'];
    isCorrect = json['is_correct'];
  }
}


class Attempts {
  int? attemptCount;
  List<int>? scores;

  Attempts({this.attemptCount, this.scores});

  Attempts.fromJson(Map<String, dynamic> json) {
    attemptCount = json['attempt_count'];
    scores = (json['scores'] as List<dynamic>?)
        ?.map((e) => int.tryParse(e.toString()) ?? 0)
        .toList();
  }
}

