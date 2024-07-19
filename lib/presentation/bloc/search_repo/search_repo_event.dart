abstract class SearchRepoEvent {}

class SearchQueryChanged extends SearchRepoEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class SearchRefreshRequested extends SearchRepoEvent {}

class SearchClearSearch extends SearchRepoEvent {}


