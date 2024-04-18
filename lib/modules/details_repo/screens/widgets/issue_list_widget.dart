import 'package:flutter/material.dart';

import '../../../../utils/constants/app_strings.dart';
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
          return const Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final issues = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: issues
                  .map((issue) => IssueItem(
                        item: issue,
                        onTap: () {},
                      ))
                  .toList(),
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
