import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/domain/extensions/extensions.dart';

import '../../../core/resources/strings/app_strings.dart';
import '../../bloc/home_repo/home_repo_bloc.dart';
import '../../bloc/home_repo/home_repo_event.dart';
import '../../bloc/home_repo/home_repo_state.dart';
import '../../bloc/search_repo/search_repo_bloc.dart';
import '../../bloc/search_repo/search_repo_event.dart';
import '../../bloc/search_repo/search_repo_state.dart';
import '../details_repo/details_repo_screen.dart';
import '../search_repo/search_screen.dart';
import '../search_repo/widgets/repo_item.dart';
import 'widgets/settings_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeRepoBloc>().add(HomeInitialRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsWidget(),
      appBar: AppBar(
        title: const Text('GitHub Repo Search'),
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
      ),
      body: BlocBuilder<HomeRepoBloc, HomeRepoState>(
        builder: (context, state) {
          if (state is HomeRepoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeRepoLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeRepoBloc>().add(HomeInitialRequested());
              },
              child: ListView.builder(
                itemCount: state.repos.length,
                itemBuilder: (BuildContext context, int index) {
                  final repo = state.repos[index];
                  return RepoItem(
                    repo: repo,
                    onTap: () {
                      context.push(DetailsRepoScreen(repo: repo));
                    },
                  );
                },
              ),
            );
          } else if (state is HomeRepoErrorState) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text(AppStrings.pullToRefresh));
        },
      ),
    );
  }
}
