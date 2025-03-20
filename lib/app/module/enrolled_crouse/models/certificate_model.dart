class CertificateModel {
  List<Data>? data;

  CertificateModel({this.data});

  CertificateModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? title;
  String? certificate;
  int? status;

  Data({this.id, this.userId, this.title, this.certificate, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    certificate = json['certificate'];
    status = json['status'];
  }
}
