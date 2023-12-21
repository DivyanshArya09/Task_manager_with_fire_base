class TodosModel {
  late String title;
  late String subtitle;
  late String id;
  late String createdAt;
  String? updatedAt;
  late bool completed;

  TodosModel(
      {required this.title,
      required this.subtitle,
      required this.id,
      required this.createdAt,
      this.updatedAt,
      required this.completed});

  TodosModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
