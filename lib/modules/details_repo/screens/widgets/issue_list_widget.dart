import 'package:flutter/material.dart';
import 'package:github_search_app/modules/details_repo/screens/widgets/scrollable_content_widget.dart';

import '../../../../resources/strings/app_strings.dart';
import '../../models/issue_model.dart';
import 'issue_item.dart';

class IssueListWidget extends StatelessWidget {
  final Future<List<IssueModel>> future;

  const IssueListWidget({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IssueModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final issues = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ScrollableContentWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: issues
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
      },
    );
  }
}
