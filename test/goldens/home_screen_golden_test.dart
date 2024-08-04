import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_app/data/models/repo_data_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:github_search_app/presentation/screens/home/home_screen.dart';
import 'package:github_search_app/presentation/bloc/home_repo/home_repo_bloc.dart';
import 'package:github_search_app/presentation/bloc/home_repo/home_repo_event.dart';
import 'package:github_search_app/presentation/bloc/home_repo/home_repo_state.dart';
import 'package:github_search_app/domain/repositories/home_repository.dart';

// Mocking HomeRepository
class MockHomeRepository extends Mock implements HomeRepository {}

// Mocking HomeRepoBloc
class MockHomeRepoBloc extends MockBloc<HomeRepoEvent, HomeRepoState> implements HomeRepoBloc {}

void main() {
  late HomeRepository homeRepository;
  late HomeRepoBloc homeRepoBloc;

  setUp(() {
    homeRepository = MockHomeRepository();
    homeRepoBloc = MockHomeRepoBloc();
  });

  testGoldens('HomeScreen golden test', (WidgetTester tester) async {
    // Define mock behaviors
    final repos = [
      RepoDataModel(
          htmlUrl: 'https://github.com/Incorrect/URL',
          watchersCount: 0,
          language: 'Unknown',
          description: 'Incorrect Description',
          name: 'incorrect-name',
          owner: 'IncorrectOwner',
          openIssuesCount: 0,
          stargazersCount: 0,
          avatarUrl: ''),
      RepoDataModel(
          htmlUrl: 'https://github.com/Incorrect/URL',
          watchersCount: 0,
          language: 'Unknown',
          description: 'Incorrect Description',
          name: 'incorrect-name',
          owner: 'IncorrectOwner',
          openIssuesCount: 0,
          stargazersCount: 0,
          avatarUrl: ''),
    ];

    when(() => homeRepository.getTrendingRepositories()).thenAnswer((_) async => repos);

    whenListen(
      homeRepoBloc,
      Stream.fromIterable([
        HomeRepoLoadingState(),
        HomeRepoLoadedState(repos),
      ]),
      initialState: HomeRepoInitialState(),
    );

    await tester.pumpWidget(
      BlocProvider<HomeRepoBloc>(
        create: (_) => homeRepoBloc,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Pump the widget with a delay to allow any async operations to complete
    await tester.pumpAndSettle();

    await multiScreenGolden(tester, 'home_screen_loaded_state');
  });

  testGoldens('HomeScreen golden test with error', (WidgetTester tester) async {
    whenListen(
      homeRepoBloc,
      Stream.fromIterable([
        HomeRepoLoadingState(),
        HomeRepoErrorState('Error fetching data'),
      ]),
      initialState: HomeRepoInitialState(),
    );

    await tester.pumpWidget(
      BlocProvider<HomeRepoBloc>(
        create: (_) => homeRepoBloc,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Pump the widget with a delay to allow any async operations to complete
    await tester.pumpAndSettle();

    await multiScreenGolden(tester, 'home_screen_error_state');
  });
}
