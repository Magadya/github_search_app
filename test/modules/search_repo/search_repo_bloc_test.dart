import 'package:date_format/date_format.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_bloc.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_event.dart';
import 'package:github_search_app/modules/search_repo/bloc/search_repo_state.dart';
import 'package:github_search_app/modules/search_repo/repository/search_repo_repository.dart';
import 'package:github_search_app/source/networking/api_constants.dart';
import 'package:github_search_app/source/networking/api_result_handler.dart';
import 'package:github_search_app/source/networking/network.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';


import 'package:get_it/get_it.dart';


// Define a mock class for NetworkDio
class MockNetworkDio extends Mock implements NetworkDio {}

void main() {
  final sl = GetIt.instance;

  group('SearchRepository Tests', () {
    late MockNetworkDio mockNetworkDio;
    late SearchRepository searchRepository;

    setUp(() {
      // Reset GetIt before each test
      sl.reset();

      // Register mock dependencies
      mockNetworkDio = MockNetworkDio();
      sl.registerLazySingleton<NetworkDio>(() => mockNetworkDio);

      // Initialize the repository with the mocked NetworkDio
      searchRepository = SearchRepository();
    });

    test('getTrendingRepositories returns ApiSuccess', () async {
      final lastWeek = DateTime.now().subtract(const Duration(days: 7));
      final formattedDate = formatDate(lastWeek, [yyyy, '-', mm, '-', dd]);

      // Mock response for getTrendingRepositories
      when(mockNetworkDio.getData(
        endPoint: ApiConstants.searchRepositories,
        queryParameters: {
          'q': 'created:>$formattedDate',
          'sort': 'stars',
          'order': 'desc',
          'page': '0',
          'per_page': '25',
        },
      )).thenAnswer((_) async => ApiSuccess({'items': []}, 200));

      final result = await searchRepository.getTrendingRepositories();

      expect(result, isA<ApiSuccess>());
    });

    test('getRepositoriesWithSearchQuery returns ApiSuccess', () async {
      // Mock response for getRepositoriesWithSearchQuery
      when(mockNetworkDio.getData(
        endPoint: ApiConstants.searchRepositories,
        queryParameters: {
          'q': 'query',
          'sort': 'stars',
          'order': 'desc',
          'page': '0',
          'per_page': '25',
        },
      )).thenAnswer((_) async => ApiSuccess({'items': []}, 200));

      final result = await searchRepository.getRepositoriesWithSearchQuery('query');

      expect(result, isA<ApiSuccess>());
    });
  });

  group('SearchRepoBloc Tests', () {
    late SearchRepoBloc bloc;
    late MockNetworkDio mockNetworkDio;
    late SearchRepository searchRepository;

    setUp(() {
      // Reset GetIt before each test
      sl.reset();

      // Register mock dependencies
      mockNetworkDio = MockNetworkDio();
      sl.registerLazySingleton<NetworkDio>(() => mockNetworkDio);

      // Initialize the repository with the mocked NetworkDio
      searchRepository = SearchRepository();
      sl.registerLazySingleton<SearchRepository>(() => searchRepository);

      // Initialize the bloc with the mocked SearchRepository
      bloc = SearchRepoBloc(searchRepository: sl<SearchRepository>());
    });

    tearDown(() {
      bloc.close();
      sl.reset();
    });

    test('initial state is correct', () {
      expect(bloc.state, equals(SearchRepoInitialState()));
    });

    blocTest<SearchRepoBloc, SearchRepoState>(
      'emits [SearchRepoLoadingState, SearchRepoLoadedState] on successful search query',
      build: () {
        // Mock response for successful search query
        when(mockNetworkDio.getData(
          endPoint: ApiConstants.searchRepositories,
          queryParameters: {
            'q': 'mobile-sdk-ios',
            'sort': 'stars',
            'order': 'desc',
            'page': '0',
            'per_page': '25',
          },
        )).thenAnswer((_) async => ApiSuccess({
          'items': [
            {
              'html_url': 'https://github.com/Jumio/mobile-sdk-ios',
              'watchers_count': 15,
              'language': 'Swift',
              'description': 'Jumio Mobile SDK for iOS',
              'name': 'mobile-sdk-ios',
              'owner': {'login': 'Jumio'},
              'open_issues_count': 2
            }
          ]
        }, 200));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('mobile-sdk-ios')),
      expect: () => [
        SearchRepoLoadingState(),
        isA<SearchRepoLoadedState>(),
      ],
    );

    blocTest<SearchRepoBloc, SearchRepoState>(
      'emits [SearchRepoLoadingState, SearchRepoErrorState] on API failure',
      build: () {
        when(mockNetworkDio.getData(
          endPoint: ApiConstants.searchRepositories,
          queryParameters: {
            'q': 'invalid_query',
            'sort': 'stars',
            'order': 'desc',
            'page': '0',
            'per_page': '25',
          },
        )).thenAnswer((_) async => ApiFailure('Failed to fetch data'));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchQueryChanged('invalid_query')),
      expect: () => [
        SearchRepoLoadingState(),
        isA<SearchRepoErrorState>(),
      ],
    );

    // Add more tests as needed
  });
}
