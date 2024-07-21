import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search_app/core/resources/app_constants.dart';
import 'package:github_search_app/core/resources/strings/app_strings.dart';
import 'package:github_search_app/data/models/repo_data_model.dart';
import 'package:github_search_app/domain/repositories/search_repository.dart';
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_bloc.dart';
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_event.dart';
import 'package:github_search_app/presentation/screens/search_repo/search_screen.dart';

import 'package:mockito/mockito.dart';

import '../../mocks/mock_search.mocks.dart';

final sl = GetIt.instance;

void main() {
  late MockSearchRepository mockSearchRepository;
  late SearchRepoBloc searchRepoBloc;

  setUpAll(() {
    sl.registerLazySingleton<SearchRepository>(() => MockSearchRepository());
  });

  setUp(() {
    mockSearchRepository = sl<SearchRepository>() as MockSearchRepository;
    searchRepoBloc = SearchRepoBloc(searchRepository: mockSearchRepository);

    reset(mockSearchRepository);
  });

  tearDown(() {
    searchRepoBloc.close();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<SearchRepoBloc>(
        create: (_) => searchRepoBloc,
        child: const SearchScreen(),
      ),
    );
  }

  testWidgets('displays hint text when initialized', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.typeToSearch), findsOneWidget);
    expect(find.byIcon(Icons.cancel_outlined), findsOneWidget);
  });

  // testWidgets('displays loading indicator when state is SearchRepoLoadingState', (WidgetTester tester) async {
  //   // Arrange
  //   when(mockSearchRepository.getRepositoriesWithSearchQuery(any)).thenAnswer((_) async => []);
  //
  //   // Create the widget tree with the BLoC
  //   await tester.pumpWidget(createTestWidget());
  //
  //   // Act
  //   // final searchField = find.byKey(AppConstants.keySearchText);
  //   // await tester.enterText(searchField, "testing");
  //   searchRepoBloc.add(SearchQueryChanged('flutter'));
  //
  //   // Trigger a rebuild after entering text
  //   await tester.pump();
  //
  //   // Allow the debounce period to pass and trigger another rebuild
  //   await tester.pump(const Duration(milliseconds: 900));
  //   await tester.pump(); // Process state change
  //
  //   // Debug logs to check BLoC state
  //   print('Bloc state after debounce: ${searchRepoBloc.state}');
  //
  //   // Add an additional pump to ensure the widget tree is rebuilt
  //   await tester.pumpAndSettle();
  //
  //   // Assert
  //   // Check for the loading indicator
  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });
}
