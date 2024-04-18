class RepoDataModel {
  final String name;
  final String owner;
  final String htmlUrl;
  final int watchersCount;
  final int openIssuesCount;
  final String language;
  final String description;

  RepoDataModel({

    required this.name,
    required this.owner,
    required this.htmlUrl,
    required this.watchersCount,
    required this.openIssuesCount,
    required this.language,
    required this.description,
  });

  static List<RepoDataModel> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList.map((r) => RepoDataModel(
      name: r['name'] as String? ?? 'Unnamed',
      owner: r['owner']['login'] as String? ?? 'Unknown owner',
      htmlUrl: r['html_url'] as String? ?? '',
      watchersCount: r['watchers_count'] as int? ?? 0,
      language: r['language'] as String? ?? 'Unknown',
      openIssuesCount:r['open_issues_count'] as int? ?? 0,
      description: r['description'] as String? ?? 'No description',
    )).toList();
  }
}