import 'package:github_search_app/data/datasource/pulls_datasource.dart';

import '../../core/networking/api_result_handler.dart';
import '../../core/networking/errors/custom_exception.dart';


import '../../domain/repositories/pulls_repository.dart';
import '../models/pull_data_model.dart';

class PullsRepositoryImpl implements PullsRepository {
  PullsRepositoryImpl();

  final _source = PullsDatasource();

  @override
  Future<List<PullDataModel>?> fetchAllPulls(String owner, String name) async {
    final apiResults = await _source.fetchAllPulls(owner, name);
    if (apiResults is ApiSuccess) {
      final items = PullDataModel.listFromJson(apiResults.data);
      return items;
    } else if (apiResults is ApiFailure) {
      throw CustomException(apiResults.message);
    } else {
      throw CustomException('Unexpected API result');
    }
  }
}
