import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/presentation/screens/details_repo/widgets/pull_item.dart';
import 'package:github_search_app/presentation/screens/details_repo/widgets/scrollable_content_widget.dart';



import '../../../../core/resources/strings/app_strings.dart';


import '../../../../data/repositories/pulls_repository_impl.dart';
import '../../../cubit/pulls/pulls_cubit.dart';
import '../../../cubit/pulls/pulls_state.dart';


class PullListWidget extends StatefulWidget {
  final String owner;
  final String name;

  const PullListWidget({required this.owner, required this.name, super.key});

  @override
  State<PullListWidget> createState() => _PullListWidgetState();
}

class _PullListWidgetState extends State<PullListWidget> with AutomaticKeepAliveClientMixin<PullListWidget> {
  @override
  void initState() {
    super.initState();
    // Any additional initialization if needed
  }

  @override
  Widget build(BuildContext context) {
    // Ensure the keep-alive functionality is properly integrated
    return BlocProvider<PullsCubit>(
      create: (context) => PullsCubit(PullsRepositoryImpl())..initStateEvent(widget.owner, widget.name),
      child: BlocConsumer<PullsCubit, PullsState>(
        listener: (context, state) {
          if (state.status == PullsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.backendError ?? AppStrings.smthGetWrong)),
            );
          }
        },
        builder: (context, state) {
          if (state.status == PullsStatus.initialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PullsStatus.pending) {
            if ((state.items ?? []).isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ScrollableContentWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.items!
                        .map((pull) => PullItem(
                      item: pull,
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
                  child: Text(AppStrings.noPulls),
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

