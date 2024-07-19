
import '../models/pull_data_model.dart';

enum PullsStatus {
  initialLoading,
  pending,
  sending,
  error,
}

class PullsState {
  final List<PullDataModel>? items;
  final PullsStatus status;
  final String? backendError;

  PullsState({
    this.items,
    this.status = PullsStatus.initialLoading,
    this.backendError,
  });

  PullsState copyWith({
    List<PullDataModel>? items,
    PullsStatus? status,
    String? backendError,
  }) {
    return PullsState(
      items: items,
      status: status ?? this.status,
      backendError: backendError ?? this.backendError,
    );
  }

}
