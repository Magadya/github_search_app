import 'package:equatable/equatable.dart';

import '../../../data/models/repo_data_model.dart';

abstract class HomeRepoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeRepoInitialState extends HomeRepoState {}

class HomeRepoLoadingState extends HomeRepoState {}

class HomeRepoLoadedState extends HomeRepoState {
  final List<RepoDataModel> repos;

  HomeRepoLoadedState(this.repos);

  @override
  List<Object?> get props => [repos];
}

class HomeRepoErrorState extends HomeRepoState {
  final String message;

  HomeRepoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}