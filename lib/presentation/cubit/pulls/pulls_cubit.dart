import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/pulls_repository.dart';
import 'pulls_state.dart';

class PullsCubit extends Cubit<PullsState> {
  final PullsRepository pullsRepository;

  PullsCubit(this.pullsRepository) : super(PullsState());

  Future<void> initStateEvent(owner, name) async {
    emit(state.copyWith(status: PullsStatus.initialLoading));
    try {
      final data = await pullsRepository.fetchAllPulls(owner, name);
      emit(state.copyWith(status: PullsStatus.pending, items: data));
    } catch (e) {
      emit(state.copyWith(status: PullsStatus.initialLoading, backendError: e.toString()));
    }
  }
}
