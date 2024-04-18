import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/home/home_screen.dart';
import 'modules/search_repo/bloc/search_repo_bloc.dart';
import 'modules/search_repo/repository/search_repo_repository.dart';

void main() {
  runApp(
    BlocProvider<SearchRepoBloc>(
      create: (context) => SearchRepoBloc(SearchRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repo Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => SearchRepoBloc(SearchRepository()),
        child: const HomeScreen(),
      ),
    );
  }
}