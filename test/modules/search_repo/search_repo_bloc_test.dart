import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_bloc.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_event.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_state.dart';
import 'package:github_search_app/modules/search_repo/models/repo_data_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/search_repository_mock.mocks.dart';

void main() {
  group('SearchRepoBloc Tests', () {
    late SearchRepoBloc bloc;
    late MockSearchRepository mockSearchRepository;

    setUp(() {
      mockSearchRepository = MockSearchRepository();
      bloc = SearchRepoBloc(mockSearchRepository);
    });

    test('initial state is correct', () {
      expect(bloc.state, equals(SearchRepoInitialState()));
    });

    blocTest<SearchRepoBloc, SearchRepoState>(
      'emits [SearchRepoLoadingState, SearchRepoLoadedState] on successful search query ',
      build: () {
        when(mockSearchRepository.getRepositoriesWithSearchQuery(any)).thenAnswer((_) async => [
              RepoDataModel(
                  htmlUrl: 'https://github.com/Jumio/mobile-sdk-ios',
                  watchersCount: 15,
                  language: 'Swift',
                  description: 'Jumio Mobile SDK for iOS',
                  name: 'mobile-sdk-ios',
                  owner: 'Jumio',
                  openIssuesCount: 2)
            ]);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('mobile-sdk-ios')),
      expect: () => [
        SearchRepoLoadingState(),
        isA<SearchRepoLoadedState>(),
      ],
    );

    blocTest<SearchRepoBloc, SearchRepoState>(
      'emits [SearchRepoLoadingState, SearchRepoLoadedState] on successful search query with zero result for a non-existent repository',
      build: () {
        when(mockSearchRepository.getRepositoriesWithSearchQuery(any)).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('mobile-sdk-ios999')),
      expect: () => [
        SearchRepoLoadingState(),
        SearchRepoLoadedState(const []),
      ],
    );
  });
}
