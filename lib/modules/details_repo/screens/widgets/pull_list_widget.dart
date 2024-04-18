import 'package:flutter/material.dart';
import 'package:github_search_app/modules/details_repo/screens/widgets/pull_item.dart';

import '../../../../resources/strings/app_strings.dart';
import '../../models/pull_data_model.dart';

class PullListWidget extends StatelessWidget {
  final Future<List<PullDataModel>> future;

  const PullListWidget({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PullDataModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final items = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map((item) => PullItem(
                        item: item,
                        onTap: () {},
                      ))
                  .toList(),
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
      },
    );
  }
}
