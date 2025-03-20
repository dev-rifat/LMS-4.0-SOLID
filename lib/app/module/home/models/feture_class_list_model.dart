class FeatureClassesListModel {
  Apps? apps;

  FeatureClassesListModel({this.apps});

  FeatureClassesListModel.fromJson(Map<String, dynamic> json) {
    apps = json['apps'] != null ? new Apps.fromJson(json['apps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apps != null) {
      data['apps'] = this.apps!.toJson();
    }
    return data;
  }
}

class Apps {
  String? name;
  String? image1;
  String? image2;
  String? image3;
  String? image4;

  Apps({this.name, this.image1, this.image2, this.image3, this.image4});

  Apps.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image1 = json['image_1'];
    image2 = json['image_2'];
    image3 = json['image_3'];
    image4 = json['image_4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image_1'] = this.image1;
    data['image_2'] = this.image2;
    data['image_3'] = this.image3;
    data['image_4'] = this.image4;
    return data;
  }
}
