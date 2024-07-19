import 'package:date_format/date_format.dart';
import 'package:github_search_app/modules/search_repo/models/repo_data_model.dart';
import 'package:github_search_app/source/networking/exceptions/custom_exception.dart';
import 'package:github_search_app/source/networking/network.dart';

import '../../../source/networking/api_constants.dart';
import '../../../source/networking/api_result_handler.dart';

abstract class SearchRepository {
  Future<List<RepoDataModel>> getTrendingRepositories();
  Future<List<RepoDataModel>> getRepositoriesWithSearchQuery(String query);
}

class SearchRepoDataSourceImpl implements SearchRepository {
  late final NetworkDio networkDio;

  @override
  Future<List<RepoDataModel>> getRepositoriesWithSearchQuery(String query) async {
    final apiResults = await networkDio.getData(
      endPoint: ApiConstants.searchRepositories,
      queryParameters: {
        'q': query,
        'sort': 'stars',
        'order': 'desc',
        'page': '0',
        'per_page': '25',
      },
    );
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
    final lastWeek = DateTime.now().subtract(const Duration(days: 7));
    final formattedDate = formatDate(lastWeek, [yyyy, '-', mm, '-', dd]);

    final apiResults = await networkDio.getData(
      endPoint: ApiConstants.searchRepositories,
      queryParameters: {
        'q': 'created:>$formattedDate',
        'sort': 'stars',
        'order': 'desc',
        'page': '0',
        'per_page': '25',
      },
    );
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
