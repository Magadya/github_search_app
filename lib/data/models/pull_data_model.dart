import 'package:github_search_app/data/models/state_enum.dart';


class PullDataModel {
  final String title;
  final StateStatus state;
  final DateTime createdAt;

  PullDataModel({required this.title, required this.state, required this.createdAt});

  static List<PullDataModel> listFromJson(List<dynamic> list) {
    return list.map((dynamic json) => PullDataModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  factory PullDataModel.fromJson(Map<String, dynamic> json) {
    return PullDataModel(
      title: json['title'] as String,
      state: (json['state'] as String).parseToState,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
