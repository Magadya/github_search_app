import '../di/di.dart';
import '../../core/networking/api_constants.dart';
import '../../core/networking/api_result_handler.dart';
import '../../core/networking/network.dart';

class SearchRepositoryDatasource {
  Future<ApiResults> getRepositoriesWithSearchQuery(String query) async {
    return await sl<NetworkDio>().getData(
      endPoint: ApiConstants.searchRepositories,
      queryParameters: {
        'q': query,
        'sort': 'stars',
        'order': 'desc',
        'page': '0',
        'per_page': '25',
      },
    );
  }
}
