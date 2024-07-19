import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../source/networking/api_result_handler.dart';
import '../models/issue_model.dart';
import '../repository/issues_repository.dart';
import 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  IssuesCubit() : super(IssuesState());

  Future<void> initStateEvent(owner,name) async {
    emit(state.copyWith(status: IssuesStatus.initialLoading));
    ApiResults apiResults = await IssuesRepository().fetchAllIssues(owner, name);
    if (apiResults is ApiSuccess) {
      final data = IssueModel.listFromJson(apiResults.data ?? []);
      emit(state.copyWith(status: IssuesStatus.pending,items: data));
    } else if (apiResults is ApiFailure) {
      emit(state.copyWith(status: IssuesStatus.initialLoading,backendError: apiResults.message));
    }
  }
}
