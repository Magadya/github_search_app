import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_event.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_state.dart';

import '../../../source/networking/api_result_handler.dart';
import '../datasource/search_repo_datasource.dart';
import '../models/repo_data_model.dart';
import '../repository/search_repo_repository.dart';

class SearchRepoBloc extends Bloc<SearchRepoEvent, SearchRepoState> {
  final SearchRepository searchRepository;

  SearchRepoBloc({required this.searchRepository}) : super(SearchRepoInitialState()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchRefreshRequested>(_onSearchRefreshRequested);
    on<SearchClearSearch>(_onSearchClearSearch);
  }

  Future<void> _onSearchQueryChanged(SearchQueryChanged event, Emitter<SearchRepoState> emit) async {
    emit(SearchRepoLoadingState());
    final apiResults = await searchRepository.getRepositoriesWithSearchQuery(event.query);
    if (apiResults is ApiSuccess) {
      emit(SearchRepoLoadedState(apiResults));
    } else if (apiResults is ApiFailure) {
      emit(SearchRepoErrorState(apiResults.message));
    } else {
      emit(SearchRepoErrorState());
    }
  }

  Future<void> _onSearchRefreshRequested(SearchRefreshRequested event, Emitter<SearchRepoState> emit) async {
    final apiResults = await searchRepository.getTrendingRepositories();
    _handleApiResults(apiResults, emit);
  }

  void _onSearchClearSearch(SearchClearSearch event, Emitter<SearchRepoState> emit) {
    emit(SearchRepoInitialState());
  }

  void _handleApiResults(ApiResults apiResults, Emitter<SearchRepoState> emit) {
    if (apiResults is ApiSuccess) {
      final repos = RepoDataModel.mapJSONStringToList(apiResults.data['items'] ?? []);
      emit(SearchRepoLoadedState(repos));
    } else if (apiResults is ApiFailure) {
      emit(SearchRepoErrorState(apiResults.message));
    }
  }
}
