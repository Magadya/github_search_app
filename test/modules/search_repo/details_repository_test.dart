import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_app/modules/details_repo/models/issue_model.dart';
import 'package:github_search_app/modules/details_repo/models/state_enum.dart';

import 'package:mockito/mockito.dart';

import '../mocks/details_repository_mock.mocks.dart';

void main() {
  group('Api Service Tests', () {
    late MockDetailsRepoRepository mockDetailsRepoRepository;
    const owner = 'immich123';
    const name = 'immich-app123';

    setUp(() {
      mockDetailsRepoRepository = MockDetailsRepoRepository();
    });

    final issues = [
      IssueModel(title: 'title1', state: StateStatus.unknown, createdAt: DateTime.now()),
      IssueModel(title: 'title2', state: StateStatus.unknown, createdAt: DateTime.now())
    ];

    test('should change state into success, and returns issues', () async {
      // Arrange

      when(mockDetailsRepoRepository.fetchAllIssues(owner, name)).thenAnswer((_) async => issues);

      // Act
      final result = await mockDetailsRepoRepository.fetchAllIssues(owner, name);

      // Assert
      expect(result, equals(issues));

      // Verify
      verify(mockDetailsRepoRepository.fetchAllIssues(owner, name)).called(1);
    });

    test('should change state into success, and returns zero issues for a non-existent repository ', () async {
      // Arrange

      when(mockDetailsRepoRepository.fetchAllIssues(owner, name)).thenAnswer((_) async => []);

      // Act
      final result = await mockDetailsRepoRepository.fetchAllIssues(owner, name);

      // Assert
      expect(result, equals([]));

      // Verify
      verify(mockDetailsRepoRepository.fetchAllIssues(owner, name)).called(1);
    });
  });
}
