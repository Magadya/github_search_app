import 'package:flutter/material.dart';
import 'package:github_search_app/modules/details_repo/screens/widgets/issue_list_widget.dart';
import 'package:github_search_app/modules/details_repo/screens/widgets/pull_list_widget.dart';
import 'package:github_search_app/modules/details_repo/screens/widgets/scrollable_content_widget.dart';

import '../../../resources/strings/app_strings.dart';
import '../../search_repo/models/repo_data_model.dart';
import '../repository/details_repo_repository.dart';

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
    final detailsRepository = DetailsRepoRepository();
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
                Text(widget.repo.name, style: Theme.of(context).textTheme.titleLarge),
                Text('Owner: ${widget.repo.owner}', style: Theme.of(context).textTheme.titleMedium),
                Text('Language: ${widget.repo.language}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Description: ${widget.repo.description}', style: Theme.of(context).textTheme.bodyMedium),
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
                      Tab(icon: Text(AppStrings.issues, style: Theme.of(context).textTheme.titleMedium)),
                      Tab(icon: Text(AppStrings.pullRequests, style: Theme.of(context).textTheme.titleMedium)),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Center(
                      child: ScrollableContentWidget(
                        child: Column(
                          children: [
                            IssueListWidget(
                              future: detailsRepository.fetchAllIssues(widget.repo.owner, widget.repo.name),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: ScrollableContentWidget(
                        child: Column(
                          children: [
                            PullListWidget(
                              future: detailsRepository.fetchAllPulls(widget.repo.owner, widget.repo.name),
                            ),
                          ],
                        ),
                      ),
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
