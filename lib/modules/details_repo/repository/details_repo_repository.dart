import 'dart:async';
import 'package:github_search_app/modules/details_repo/models/pull_data_model.dart';

import '../../api_services/github_api_service.dart';
import '../models/issue_model.dart';

class DetailsRepoRepository {
  Future<List<IssueModel>> fetchAllIssues(String owner, String name) => GithubApiService.fetchAllIssues(owner,name);

  Future<List<PullDataModel>> fetchAllPulls(String owner, String name) => GithubApiService.fetchAllPulls(owner,name);
}
