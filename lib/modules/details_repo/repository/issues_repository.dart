import 'dart:async';

import '../../../data/di/di.dart';
import '../../../source/networking/api_constants.dart';
import '../../../source/networking/api_result_handler.dart';
import '../../../source/networking/network.dart';


class IssuesRepository {
  Future<ApiResults> fetchAllIssues(String owner, String name) async {
    return await sl<NetworkDio>().getData(
      endPoint: ApiConstants.fetchAllIssues(owner, name),
      queryParameters: {
        'state': 'all',
      },
    );
  }
}
