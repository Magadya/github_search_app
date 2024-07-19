import 'package:date_format/date_format.dart';
import '../di/di.dart';
import '../../core/networking/api_constants.dart';
import '../../core/networking/api_result_handler.dart';
import '../../core/networking/network.dart';



class PullsDatasource {
  Future<ApiResults> fetchAllPulls(String owner, String name) async {
    return await sl<NetworkDio>().getData(
      endPoint: ApiConstants.fetchAllPulls(owner, name),
      queryParameters: {
        'state': 'all',
      },
    );
  }
}
