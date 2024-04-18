import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_event.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_state.dart';

import '../repository/search_repo_repository.dart';

class SearchRepoBloc extends Bloc<SearchRepoEvent, SearchRepoState> {
  final SearchRepository _repository;

  SearchRepoBloc(this._repository) : super(SearchRepoInitialState()) {
    on<SearchQueryChanged>((event, emit) async {
      emit(SearchRepoLoadingState());
      try {
        final repos =
        await _repository.getRepositoriesWithSearchQuery(event.query);
        repos.sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        emit(SearchRepoLoadedState(repos));
      } catch (e) {
        emit(SearchRepoErrorState(e.toString()));
      }
    });

    on<SearchRefreshRequested>((event, emit) async {
      try {
        final repos = await _repository.getTrendingRepositories();
        emit(SearchRepoLoadedState(repos));
      } catch (e) {
        emit(SearchRepoErrorState(e.toString()));
      }
    });

    on<SearchClearSearch>((event, emit) {
      emit(SearchRepoInitialState());
    });
  }
}