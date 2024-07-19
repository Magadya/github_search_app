import '../../../data/di/di.dart';
import '../../../source/networking/api_constants.dart';
import '../../../source/networking/api_result_handler.dart';
import '../../../source/networking/network.dart';

class PullsRepository {
  Future<ApiResults> fetchAllPulls(String owner, String name) async {
    return await sl<NetworkDio>().getData(
      endPoint: ApiConstants.fetchAllPulls(owner, name),
      queryParameters: {
        'state': 'all',
      },
    );
  }
}
