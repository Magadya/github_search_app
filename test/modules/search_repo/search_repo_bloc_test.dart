import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search_app/core/resources/strings/app_strings.dart';
import 'package:github_search_app/data/models/repo_data_model.dart';
import 'package:github_search_app/domain/repositories/search_repository.dart';
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_event.dart';
import 'package:github_search_app/presentation/screens/search_repo/search_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
// Adjust the import according to your project structure
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_bloc.dart'; // Adjust the import according to your project structure
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_state.dart'; // Adjust the import according to your project structure
import '../mocks/mock_search_repository.mocks.dart'; // Adjust the import according to your generated mock file


import '../mocks/mock_search_repository.mocks.dart';

void main() {
  final sl = GetIt.instance;

  setUpAll(() {
    // Register the mock SearchRepository instance
    sl.registerLazySingleton<SearchRepository>(() => MockSearchRepository());
  });

  group('SearchRepoBloc Tests', () {
    late SearchRepoBloc bloc;
    late MockSearchRepository mockSearchRepository;

    setUp(() {
      // Correctly assign the mock instance before use
      mockSearchRepository = sl<SearchRepository>() as MockSearchRepository;

      // Initialize the bloc with the mocked SearchRepository
      bloc = SearchRepoBloc(searchRepository: mockSearchRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is correct', () {
      expect(bloc.state, equals(SearchRepoInitialState()));
    });

    blocTest<SearchRepoBloc, SearchRepoState>(
      'emits [SearchRepoLoadingState, SearchRepoLoadedState] on successful search query',
      build: () {
        // Correctly use `any` with a type argument
        when(mockSearchRepository.getRepositoriesWithSearchQuery('mobile-sdk-ios')).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('mobile-sdk-ios')),
      expect: () => [
        SearchRepoLoadingState(),
        isA<SearchRepoLoadedState>(),
      ],
    );

    // Additional tests can be refactored in a similar manner// Test for Empty List
    blocTest<SearchRepoBloc, SearchRepoState>(
      'emits [SearchRepoLoadingState, SearchRepoLoadedState] with empty list on search query',
      build: () {
        when(mockSearchRepository.getRepositoriesWithSearchQuery(any)).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('query_with_no_results')),
      expect: () => [
        SearchRepoLoadingState(),
        SearchRepoLoadedState([]),
      ],
    );

// Test for Specific List
//     blocTest<SearchRepoBloc, SearchRepoState>(
//       'should fail when the search query is Magadya/github_search_app and the response does not match expected data',
//       build: () {
//         // Mocking a response that does not match the expected outcome
//         when(mockSearchRepository.getRepositoriesWithSearchQuery(any)).thenAnswer((_) async => [
//               RepoDataModel(
//                   htmlUrl: 'https://github.com/Incorrect/URL',
//                   watchersCount: 0,
//                   language: 'Unknown',
//                   description: 'Incorrect Description',
//                   name: 'incorrect-name',
//                   owner: 'IncorrectOwner',
//                   openIssuesCount: 0)
//             ]);
//         return bloc;
//       },
//       act: (bloc) => bloc.add(SearchQueryChanged('Magadya/github_search_app')),
//       expect: () => [
//         SearchRepoLoadingState(),
//         predicate<SearchRepoState>((state) {
//           if (state is SearchRepoLoadedState) {
//             // Defining the expected outcome that should cause the test to fail
//             return state.repos.any((repo) =>
//                 repo.htmlUrl == 'https://github.com/Jumio/mobile-sdk-ios' &&
//                 repo.watchersCount == 15 &&
//                 repo.language == 'Swift' &&
//                 repo.description == 'Jumio Mobile SDK for iOS' &&
//                 repo.name == 'mobile-sdk-ios' &&
//                 repo.owner == 'Jumio' &&
//                 repo.openIssuesCount == 2);
//           }
//           return false;
//         }),
//       ],
//     );

    blocTest<SearchRepoBloc, SearchRepoState>(
      'should pass when the search query is Magadya/github_search_app and the response does match expected data',
      build: () {
        // Mocking a response that does not match the expected outcome
        when(mockSearchRepository.getRepositoriesWithSearchQuery(any)).thenAnswer((_) async => [
              RepoDataModel(
                  htmlUrl: 'https://github.com/Magadya/Magadya.github.io',
                  watchersCount: 0,
                  language: 'JavaScript',
                  description: 'No description',
                  name: 'Magadya.github.io',
                  owner: 'Magadya',
                  openIssuesCount: 0)
            ]);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('Magadya/github_search_app')),
      expect: () => [
        SearchRepoLoadingState(),
        predicate<SearchRepoState>((state) {
          if (state is SearchRepoLoadedState) {
            // Defining the expected outcome that should cause the test to fail
            return state.repos.any((repo) =>
                repo.htmlUrl == 'https://github.com/Magadya/Magadya.github.io' &&
                repo.watchersCount == 0 &&
                repo.language == 'JavaScript' &&
                repo.description == 'No description' &&
                repo.name == 'Magadya.github.io' &&
                repo.owner == 'Magadya' &&
                repo.openIssuesCount == 0);
          }
          return false;
        }),
      ],
    );

// Test for Exception
    blocTest<SearchRepoBloc, SearchRepoState>(
      'emits [SearchRepoLoadingState, SearchRepoErrorState] on exception',
      build: () {
        when(mockSearchRepository.getRepositoriesWithSearchQuery(any)).thenThrow(Exception('Failed to fetch data'));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('query_causing_exception')),
      expect: () => [
        SearchRepoLoadingState(),
        isA<SearchRepoErrorState>(),
      ],
    );
  });
}
