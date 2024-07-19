// import 'package:date_format/date_format.dart';
// import '../../../data/di/di.dart';
// import '../../../source/networking/api_constants.dart';
// import '../../../source/networking/api_result_handler.dart';
// import '../../../source/networking/network.dart';
//
//
//
// class SearchRepository {
//   Future<ApiResults> getTrendingRepositories() async {
//     final lastWeek = DateTime.now().subtract(const Duration(days: 7));
//     final formattedDate = formatDate(lastWeek, [yyyy, '-', mm, '-', dd]);
//     return await sl<NetworkDio>().getData(
//       endPoint: ApiConstants.searchRepositories,
//       queryParameters: {
//         'q': 'created:>$formattedDate',
//         'sort': 'stars',
//         'order': 'desc',
//         'page': '0',
//         'per_page': '25',
//       },
//     );
//   }
//
//   Future<ApiResults> getRepositoriesWithSearchQuery(String query) async {
//     return await sl<NetworkDio>().getData(
//       endPoint: ApiConstants.searchRepositories,
//       queryParameters: {
//         'q': query,
//         'sort': 'stars',
//         'order': 'desc',
//         'page': '0',
//         'per_page': '25',
//       },
//     );
//   }
//
// }
