import 'package:equatable/equatable.dart';

import '../models/repo_data_model.dart';

abstract class SearchRepoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchRepoInitialState extends SearchRepoState {}

class SearchRepoLoadingState extends SearchRepoState {}

class SearchRepoLoadedState extends SearchRepoState {
  final List<RepoDataModel> repos;

  SearchRepoLoadedState(this.repos);

  @override
  List<Object?> get props => [repos];
}

class SearchRepoErrorState extends SearchRepoState {
  final String message;

  SearchRepoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}