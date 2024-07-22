import '../../data/models/repo_data_model.dart';

abstract class SearchRepository {
  Future<List<RepoDataModel>> getRepositoriesWithSearchQuery(String query);
}
