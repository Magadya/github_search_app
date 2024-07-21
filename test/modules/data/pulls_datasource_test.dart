import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search_app/core/networking/api_constants.dart';
import 'package:github_search_app/core/networking/network.dart';
import 'package:mockito/mockito.dart';
import 'package:github_search_app/data/datasource/pulls_datasource.dart';
import 'package:github_search_app/data/models/pull_data_model.dart';
import 'package:github_search_app/data/repositories/pulls_repository_impl.dart';
import 'package:github_search_app/core/networking/api_result_handler.dart';
import 'package:github_search_app/core/networking/errors/custom_exception.dart';

import '../mocks/mock_network.mocks.dart';

final sl = GetIt.instance;

void main() {
  late PullsRepositoryImpl pullsRepositoryImpl;
  late MockNetworkDio mockNetworkDio;

  setUp(() {
    sl.registerLazySingleton<NetworkDio>(() => MockNetworkDio());
    mockNetworkDio = sl<NetworkDio>() as MockNetworkDio;

    pullsRepositoryImpl = PullsRepositoryImpl();
  });

  group('fetchAllPulls', () {
    final owner = 'Magadya';
    final name = 'Magadya.github.io';

    test('should return a list of PullDataModel when ApiSuccess is returned', () async {
      // Arrange
      final mockData = [];
      final mockApiSuccess = ApiSuccess(mockData, 200);
      //when(mockPullsDatasource.fetchAllPulls(owner, name)).thenAnswer((_) async => mockApiSuccess);
      when(mockNetworkDio.getData(
        endPoint: ApiConstants.fetchAllPulls(owner, name),
        queryParameters: {
          'state': 'all',
        },
      )).thenAnswer((_) async => mockApiSuccess);
      // Act
      final result = await pullsRepositoryImpl.fetchAllPulls(owner, name);

      // Convert mockData to PullDataModel list
      final expectedResult = PullDataModel.listFromJson(mockData);

      // Assert
      expect(result, equals(expectedResult));
    });
  });
  // test('should throw CustomException when ApiFailure is returned', () async {
  //   // Arrange
  //   final owner = 'Magadya';
  //   final name = 'Magadya.github.io';
  //   final mockApiFailure = ApiFailure('An error occurred');
  //   when(mockPullsDatasource.fetchAllPulls(owner, name))
  //       .thenAnswer((_) async => mockApiFailure);
  //
  //   // Act & Assert
  //   expect(
  //         () async => await pullsRepository.fetchAllPulls(owner, name),
  //     throwsA(isA<CustomException>()),
  //   );
  // });
  // test('should return a list of PullDataModel when ApiSuccess is returned', () async {
  //   // Arrange
  //   final owner = 'Magadya';
  //   final name = 'Magadya.github.io';
  //   final mockData = [
  //     {'id': 1, 'title': 'Pull Request 1'},
  //     {'id': 2, 'title': 'Pull Request 2'},
  //   ];
  //   final mockApiSuccess = ApiSuccess(mockData, 200);
  //   when(mockPullsDatasource.fetchAllPulls(owner, name))
  //       .thenAnswer((_) async => mockApiSuccess);
  //
  //   // Act
  //   final result = await pullsRepository.fetchAllPulls(owner, name);
  //
  //   // Convert mockData to PullDataModel list
  //   final expectedResult = PullDataModel.listFromJson(mockData);
  //
  //   // Debugging print statements
  //   print('Result: $result');
  //   print('Expected Result: $expectedResult');
  //
  //   // Assert
  //   expect(result, equals(expectedResult));
  // });
}
