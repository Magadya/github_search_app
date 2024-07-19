import 'package:github_search_app/data/datasource/issues_datasource.dart';

import '../../core/networking/api_result_handler.dart';
import '../../core/networking/errors/custom_exception.dart';
import '../../domain/repositories/issues_repository.dart';
import '../models/issue_model.dart';

class IssuesRepositoryImpl implements IssuesRepository {
  IssuesRepositoryImpl();

  final _source = IssuesDatasource();

  @override
  Future<List<IssueModel>?> fetchAllIssues(String owner, String name) async {
    final apiResults = await _source.fetchAllIssues(owner, name);
    if (apiResults is ApiSuccess) {
      final items = IssueModel.listFromJson(apiResults.data);
      return items;
    } else if (apiResults is ApiFailure) {
      throw CustomException(apiResults.message);
    } else {
      throw CustomException('Unexpected API result');
    }
  }
}
