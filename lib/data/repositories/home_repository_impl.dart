import '../../core/networking/api_result_handler.dart';
import '../../core/networking/errors/custom_exception.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_repository_datasource.dart';
import '../models/repo_data_model.dart';

class HomeRepoDataSourceImpl implements HomeRepository {
  HomeRepoDataSourceImpl();

  final _source = HomeRepositoryDatasource();

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
