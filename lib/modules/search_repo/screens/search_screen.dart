import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/modules/search_repo/screens/widgets/repo_item.dart';

import '../../../resources/strings/app_strings.dart';
import '../../details_repo/screens/details_repo_screen.dart';
import '../bloc/search_repo_bloc.dart';
import '../bloc/search_repo_event.dart';
import '../bloc/search_repo_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchQueryController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchChanged);
    _searchQueryController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchQueryController.text;
    if (query.length >= 4) {
      context.read<SearchRepoBloc>().add(SearchQueryChanged(query));
    } else {
      context.read<SearchRepoBloc>().add(SearchClearSearch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchQueryController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: AppStrings.searchHintText,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
      body: BlocConsumer<SearchRepoBloc, SearchRepoState>(
        listener: (context, state) {
          if (state is SearchRepoErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (_searchQueryController.text.length < 4) {
            return const Center(child: Text(AppStrings.typeToSearch));
          }
          if (state is SearchRepoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchRepoLoadedState) {
            return ListView.builder(
              itemCount: state.repos.length,
              itemBuilder: (BuildContext context, int index) {
                final repo = state.repos[index];
                return RepoItem(
                  repo: repo,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DetailsRepoScreen(repo: repo)),
                    );
                  },
                );
              },
            );
          } else if (state is SearchRepoErrorState) {
            return  Center(child: Text(state.message));
          }
          return const Center(child: Text(AppStrings.typeToSearch));
        },
      ),
    );
  }
}
