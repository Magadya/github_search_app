import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_app/data/models/repo_data_model.dart';
import 'package:github_search_app/domain/repositories/search_repository.dart';
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_bloc.dart';
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_event.dart';
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_state.dart';
import 'package:github_search_app/presentation/screens/search_repo/search_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_toolkit/golden_toolkit.dart';




class MockSearchRepository extends Mock implements SearchRepository {}

class MockSearchRepoBloc extends MockBloc<SearchRepoEvent, SearchRepoState> implements SearchRepoBloc {}

void main() {
  late SearchRepository searchRepository;
  late SearchRepoBloc searchRepoBloc;

  setUp(() {
    searchRepository = MockSearchRepository();
    searchRepoBloc = MockSearchRepoBloc();
  });

  testGoldens('SearchScreen intial golden test', (WidgetTester tester) async {
    // Define mock behaviors


    when(() => searchRepository.getRepositoriesWithSearchQuery('test')).thenAnswer((_) async => []);

    whenListen(
      searchRepoBloc,
      Stream.fromIterable([
        SearchRepoInitialState(),
      ]),
      initialState: SearchRepoInitialState(),
    );

    await tester.pumpWidget(
      BlocProvider<SearchRepoBloc>(
        create: (_) => searchRepoBloc,
        child: const MaterialApp(home: SearchScreen()),
      ),
    );

    // Pump the widget with a delay to allow any async operations to complete
    await tester.pumpAndSettle();

    await multiScreenGolden(tester, 'search_screen_inital_state');
  });

}
