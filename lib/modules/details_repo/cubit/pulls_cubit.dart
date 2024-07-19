import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/modules/details_repo/cubit/pulls_state.dart';

import '../../../source/networking/api_result_handler.dart';
import '../models/pull_data_model.dart';

import '../repository/pulls_repository.dart';

class PullsCubit extends Cubit<PullsState> {
  PullsCubit() : super(PullsState());

  Future<void> initStateEvent(owner, name) async {
    emit(state.copyWith(status: PullsStatus.initialLoading));
    ApiResults apiResults = await PullsRepository().fetchAllPulls(owner, name);
    if (apiResults is ApiSuccess) {
      final data = PullDataModel.listFromJson(apiResults.data ?? []);
      emit(state.copyWith(status: PullsStatus.pending, items: data));
    } else if (apiResults is ApiFailure) {
      emit(state.copyWith(status: PullsStatus.initialLoading, backendError: apiResults.message));
    }
  }
}
