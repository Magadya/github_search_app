import '../../../networking/api_services/github_api_service.dart';
import '../models/repo_data_model.dart';

class SearchRepository {
  Future<List<RepoDataModel>> getTrendingRepositories() => GithubApiService.getTrendingRepositories();

  Future<List<RepoDataModel>> getRepositoriesWithSearchQuery(String query) =>
      GithubApiService.getRepositoriesWithSearchQuery(query);
}
