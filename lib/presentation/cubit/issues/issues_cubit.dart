import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/repositories/issues_repository.dart';
import 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  final IssuesRepository issuesRepository;

  IssuesCubit(this.issuesRepository) : super(IssuesState());

  Future<void> initStateEvent(owner, name) async {
    emit(state.copyWith(status: IssuesStatus.initialLoading));
    try {
      final data = await issuesRepository.fetchAllIssues(owner, name);
      emit(state.copyWith(status: IssuesStatus.pending, items: data));
    } catch (e) {
      emit(state.copyWith(status: IssuesStatus.initialLoading, backendError: e.toString()));
    }
  }
}
