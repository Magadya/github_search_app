import 'package:flutter/material.dart';

import '../../../../data/models/repo_data_model.dart';



class RepoItem extends StatelessWidget {
  final RepoDataModel repo;
  final VoidCallback onTap;

  const RepoItem({super.key, required this.repo, required this.onTap});

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
              Text(repo.name, style: Theme.of(context).textTheme.titleMedium),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(repo.description, style: Theme.of(context).textTheme.bodyMedium),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:
                          Text(repo.owner, textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.star, color: Colors.deepOrange),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('${repo.watchersCount}',
                                textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                          Text(repo.language, textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyMedium),
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
