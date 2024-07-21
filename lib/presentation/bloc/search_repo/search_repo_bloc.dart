import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_event.dart';
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/repositories/search_repository.dart';

class SearchRepoBloc extends Bloc<SearchRepoEvent, SearchRepoState> {
  final SearchRepository searchRepository;
  StreamSubscription? _searchSubscription;

  SearchRepoBloc({required this.searchRepository}) : super(SearchRepoInitialState()) {
    on<SearchQueryChanged>(
          (event, emit) => _onSearchQueryChanged(event, emit),
      transformer: debounce<SearchQueryChanged>(const Duration(milliseconds: 500)),
    );
    on<SearchRefreshRequested>(_onSearchRefreshRequested);
    on<SearchClearSearch>(_onSearchClearSearch);
  }

  Future<void> _onSearchQueryChanged(SearchQueryChanged event, Emitter<SearchRepoState> emit) async {
    emit(SearchRepoLoadingState());
    try {
      final apiResults = await searchRepository.getRepositoriesWithSearchQuery(event.query);
      emit(SearchRepoLoadedState(apiResults));
    } catch (e) {
      emit(SearchRepoErrorState(e.toString()));
    }
  }

  Future<void> _onSearchRefreshRequested(SearchRefreshRequested event, Emitter<SearchRepoState> emit) async {
    emit(SearchRepoLoadingState());
    try {
      final apiResults = await searchRepository.getTrendingRepositories();
      emit(SearchRepoLoadedState(apiResults));
    } catch (e) {
      emit(SearchRepoErrorState(e.toString()));
    }
  }

  void _onSearchClearSearch(SearchClearSearch event, Emitter<SearchRepoState> emit) {
    emit(SearchRepoInitialState());
  }

  @override
  Future<void> close() {
    _searchSubscription?.cancel();
    return super.close();
  }

  // Helper method for applying debounce
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}