import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/presentation/bloc/home_repo/home_repo_event.dart';
import 'package:github_search_app/presentation/bloc/home_repo/home_repo_state.dart';

import '../../../domain/repositories/home_repository.dart';


class HomeRepoBloc extends Bloc<HomeRepoEvent, HomeRepoState> {
  final HomeRepository homeRepository;


  HomeRepoBloc({required this.homeRepository}) : super(HomeRepoInitialState()) {

    on<HomeInitialRequested>(_onHomeInitialRequested);
    on<HomeClearHome>(_onHomeClearHome);
  }



  Future<void> _onHomeInitialRequested(HomeInitialRequested event, Emitter<HomeRepoState> emit) async {
    emit(HomeRepoLoadingState());
    try {
      final apiResults = await homeRepository.getTrendingRepositories();
      emit(HomeRepoLoadedState(apiResults));
    } catch (e) {
      emit(HomeRepoErrorState(e.toString()));
    }
  }

  void _onHomeClearHome(HomeClearHome event, Emitter<HomeRepoState> emit) {
    emit(HomeRepoInitialState());
  }

}