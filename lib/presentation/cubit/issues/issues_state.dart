
import '../../../data/models/issue_model.dart';



enum IssuesStatus {
  initialLoading,
  pending,
  sending,
  error,
}

class IssuesState {
  final List<IssueModel>? items;
  final IssuesStatus status;
  final String? backendError;

  IssuesState({
    this.items,
    this.status = IssuesStatus.initialLoading,
    this.backendError,
  });

  IssuesState copyWith({
    List<IssueModel>? items,
    IssuesStatus? status,
    String? backendError,
  }) {
    return IssuesState(
      items: items,
      status: status ?? this.status,
      backendError: backendError ?? this.backendError,
    );
  }

}
