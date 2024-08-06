import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/domain/extensions/extensions.dart';
import 'package:github_search_app/presentation/screens/search_repo/search_screen.dart';

import '../../../bloc/search_repo/search_repo_bloc.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('GitHub Repo Search', style: TextStyle(color: Colors.black, fontSize: 14)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.push(BlocProvider.value(
              value: BlocProvider.of<SearchRepoBloc>(context, listen: false),
              child: const SearchScreen(),
            ));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
