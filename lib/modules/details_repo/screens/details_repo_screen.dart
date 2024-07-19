import 'package:flutter/material.dart';
import 'package:github_search_app/modules/details_repo/screens/widgets/issue_list_widget.dart';
import 'package:github_search_app/modules/details_repo/screens/widgets/pull_list_widget.dart';
import '../../../resources/strings/app_strings.dart';
import '../../search_repo/models/repo_data_model.dart';
import '../repository/issues_repository.dart';

class DetailsRepoScreen extends StatefulWidget {
  final RepoDataModel repo;

  const DetailsRepoScreen({
    required this.repo,
    super.key,
  });

  @override
  State<DetailsRepoScreen> createState() => _DetailsRepoScreenState();
}

class _DetailsRepoScreenState extends State<DetailsRepoScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repo.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.repo.name, style: theme.textTheme.titleLarge),
                Text('Owner: ${widget.repo.owner}', style: theme.textTheme.titleMedium),
                Text('Language: ${widget.repo.language}', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Description: ${widget.repo.description}', style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: TabBar(
                    tabs: [
                      Tab(icon: Text(AppStrings.issues, style: theme.textTheme.titleMedium)),
                      Tab(icon: Text(AppStrings.pullRequests, style: theme.textTheme.titleMedium)),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    IssueListWidget(
                       key: ValueKey('${widget.repo.owner}_${widget.repo.name}_issues'),
                      owner: widget.repo.owner,
                      name: widget.repo.name,
                    ),
                    PullListWidget(
                      key: ValueKey('${widget.repo.owner}_${widget.repo.name}_pulls'),
                      owner: widget.repo.owner,
                      name: widget.repo.name,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
