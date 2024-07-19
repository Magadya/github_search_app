import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/presentation/screens/details_repo/widgets/scrollable_content_widget.dart';

import '../../../../core/resources/strings/app_strings.dart';

import '../../../../data/repositories/issues_repository_impl.dart';
import '../../../cubit/issues/issues_cubit.dart';
import '../../../cubit/issues/issues_state.dart';
import 'issue_item.dart';

class IssueListWidget extends StatefulWidget {
  final String owner;
  final String name;

  const IssueListWidget({required this.owner, required this.name, super.key});

  @override
  State<IssueListWidget> createState() => _IssueListWidgetState();
}

class _IssueListWidgetState extends State<IssueListWidget> with AutomaticKeepAliveClientMixin<IssueListWidget> {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Ensure the keep-alive functionality is properly integrated
    return BlocProvider<IssuesCubit>(
      create: (context) => IssuesCubit(IssuesRepositoryImpl())..initStateEvent(widget.owner, widget.name),
      child: BlocConsumer<IssuesCubit, IssuesState>(
        listener: (context, state) {
          if (state.status == IssuesStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.backendError ?? AppStrings.smthGetWrong)),
            );
          }
        },
        builder: (context, state) {
          if (state.status == IssuesStatus.initialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == IssuesStatus.pending) {
            if ((state.items ?? []).isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ScrollableContentWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.items!
                        .map((issue) => IssueItem(
                              item: issue,
                              onTap: () {},
                            ))
                        .toList(),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(AppStrings.noIssues),
                ),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
