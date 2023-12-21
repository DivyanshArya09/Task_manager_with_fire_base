class categoryModel {
  static String email = '';
  late String id;
  late String title;

  categoryModel({required this.id, required this.title});

  categoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
