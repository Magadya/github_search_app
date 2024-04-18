import 'dart:io';

import 'package:date_format/date_format.dart';
import 'dart:convert' show json, utf8;
import '../details_repo/models/issue_model.dart';
import '../details_repo/models/pull_data_model.dart';
import '../search_repo/models/repo_data_model.dart';
import 'api_constants.dart';

class GithubApiService {
  static final HttpClient _httpClient = HttpClient();

  static Future<List<IssueModel>> fetchAllIssues(String owner, String name) async {
    final uri = Uri.https(ApiConstants.urlGitHub, '/repos/$owner/$name/issues', {
      'state': 'all',
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return [];
    }

    return IssueModel.listFromJson(jsonResponse);
  }

  static Future<List<PullDataModel>> fetchAllPulls(String owner, String name) async {
    final uri = Uri.https(ApiConstants.urlGitHub, '/repos/$owner/$name/pulls', {
      'state': 'all',
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return [];
    }

    return PullDataModel.listFromJson(jsonResponse);
  }

  static Future<List<RepoDataModel>> getRepositoriesWithSearchQuery(String query) async {
    final uri = Uri.https(ApiConstants.urlGitHub, '/search/repositories', {
      'q': query,
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '25',
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['errors'] != null) {
      return [];
    }

    return RepoDataModel.mapJSONStringToList(jsonResponse['items']);
  }

  static Future<List<RepoDataModel>> getTrendingRepositories() async {
    final lastWeek = DateTime.now().subtract(const Duration(days: 7));
    final formattedDate = formatDate(lastWeek, [yyyy, '-', mm, '-', dd]);

    final uri = Uri.https(ApiConstants.urlGitHub, '/search/repositories', {
      'q': 'created:>$formattedDate',
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '25',
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['errors'] != null) {
      return [];
    }
    return RepoDataModel.mapJSONStringToList(jsonResponse['items']);
  }

  static Future<dynamic> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}
