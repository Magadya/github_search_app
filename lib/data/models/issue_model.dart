
import 'package:github_search_app/data/models/state_enum.dart';

class IssueModel {
  final String title;
  final StateStatus state;
  final DateTime createdAt;

  IssueModel({required this.title, required this.state, required this.createdAt});

  static List<IssueModel> listFromJson(List<dynamic> list) {
    return list.map((dynamic json) => IssueModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      title: json['title'] as String,
      state: (json['state'] as String).parseToState,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
