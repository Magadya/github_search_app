import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/app_constants.dart';
import '../../../../data/models/issue_model.dart';
import '../../../../data/models/state_enum.dart';

class IssueItem extends StatelessWidget {
  final IssueModel item;
  final VoidCallback onTap;

  const IssueItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.lightBlueAccent,
        splashColor: Colors.red,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item.title, style: Theme.of(context).textTheme.titleMedium),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Status: ${item.state.parseToString}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: item.state == StateStatus.open ? Colors.green : Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(formatDate(item.createdAt, AppConstants.dateTimeFormat),
                          textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
