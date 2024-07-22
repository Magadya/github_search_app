

import '../../data/models/repo_data_model.dart';

abstract class HomeRepository {
  Future<List<RepoDataModel>> getTrendingRepositories();

}