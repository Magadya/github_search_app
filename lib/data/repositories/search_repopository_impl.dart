import 'package:github_search_app/data/datasource/search_repository_datasource.dart';


import '../../core/networking/api_result_handler.dart';
import '../../core/networking/errors/custom_exception.dart';
import '../../domain/repositories/search_repository.dart';
import '../models/repo_data_model.dart';



class SearchRepoDataSourceImpl implements SearchRepository {
  SearchRepoDataSourceImpl();

  final _source = SearchRepositoryDatasource();

  @override
  Future<List<RepoDataModel>> getRepositoriesWithSearchQuery(String query) async {
    final apiResults = await _source.getRepositoriesWithSearchQuery(query);
    if (apiResults is ApiSuccess) {
      final items = RepoDataModel.mapJSONStringToList(apiResults.data['items'] ?? []);
      return items;
    } else if (apiResults is ApiFailure) {
      throw CustomException(apiResults.message);
    } else {
      throw CustomException('Unexpected API result');
    }
  }

  @override
  Future<List<RepoDataModel>> getTrendingRepositories() async {
    final apiResults = await _source.getTrendingRepositories();
    if (apiResults is ApiSuccess) {
      final items = RepoDataModel.mapJSONStringToList(apiResults.data['items'] ?? []);
      return items;
    } else if (apiResults is ApiFailure) {
      throw CustomException(apiResults.message);
    } else {
      throw CustomException('Unexpected API result');
    }
  }
}
