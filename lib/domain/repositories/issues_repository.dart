
import '../../data/models/issue_model.dart';


abstract class IssuesRepository {
  Future<List<IssueModel>?> fetchAllIssues(String owner, String name);
}
