class ApiConstants {
  static const String urlGitHub = 'http://api.github.com';

  static String fetchAllIssues(owner, name) => '/repos/$owner/$name/issues';

  static String fetchAllPulls(owner, name) => '/repos/$owner/$name/pulls';

  static String searchRepositories = '/search/repositories';
}
