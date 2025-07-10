import 'package:flutter_test/flutter_test.dart';
import 'package:github/features/github/data/api/github_api.dart';
import 'package:github/features/github/data/repositories/repositories_repository_impl.dart';
import 'package:github/features/github/domain/entities/issue_entity.dart';
import 'package:github/features/github/domain/entities/pull_request_entity.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/test_data.dart';
import 'repositories_repository_impl_test.mocks.dart';

@GenerateMocks([GitHubApi])
void main() {
  group('RepositoriesRepositoryImpl', () {
    late RepositoriesRepositoryImpl repository;
    late MockGitHubApi mockApi;

    setUp(() {
      mockApi = MockGitHubApi();
      repository = RepositoriesRepositoryImpl(mockApi);
    });

    group('searchRepositories', () {
      test('should return list of repositories when API call is successful',
          () async {
        // Arrange
        const query = 'flutter';
        final mockApiResponse = TestData.apiRepositoriesResponse;

        when(mockApi.searchRepositories(query))
            .thenAnswer((_) async => mockApiResponse);

        // Act
        final result = await repository.searchRepositories(query);

        // Assert
        expect(result, isA<List<RepositoryEntity>>());
        expect(result.length, 1);
        expect(result.first.name, 'flutter');
        expect(result.first.fullName, 'flutter/flutter');
        expect(result.first.stars, 1000);
        verify(mockApi.searchRepositories(query)).called(1);
        verifyNoMoreInteractions(mockApi);
      });

      test('should return empty list when API returns empty items', () async {
        // Arrange
        const query = 'nonexistent';
        final mockApiResponse = TestData.apiRepositoriesEmptyResponse;

        when(mockApi.searchRepositories(query))
            .thenAnswer((_) async => mockApiResponse);

        // Act
        final result = await repository.searchRepositories(query);

        // Assert
        expect(result, isEmpty);
        verify(mockApi.searchRepositories(query)).called(1);
        verifyNoMoreInteractions(mockApi);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const query = 'flutter';
        when(mockApi.searchRepositories(query))
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => repository.searchRepositories(query),
          throwsA(isA<Exception>()),
        );
        verify(mockApi.searchRepositories(query)).called(1);
        verifyNoMoreInteractions(mockApi);
      });

      test('should handle malformed API response', () async {
        // Arrange
        const query = 'flutter';
        final mockApiResponse = TestData.apiRepositoriesMalformedResponse;

        when(mockApi.searchRepositories(query))
            .thenAnswer((_) async => mockApiResponse);

        // Act & Assert
        expect(
          () => repository.searchRepositories(query),
          throwsA(isA<Exception>()),
        );
        verify(mockApi.searchRepositories(query)).called(1);
        verifyNoMoreInteractions(mockApi);
      });
    });

    group('getRepositoryIssues', () {
      test('should return list of issues when API call is successful',
          () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        final mockApiResponse = TestData.apiIssuesResponse;

        when(mockApi.getRepositoryIssues(owner, repo))
            .thenAnswer((_) async => mockApiResponse);

        // Act
        final result = await repository.getRepositoryIssues(owner, repo);

        // Assert
        expect(result, isA<List<IssueEntity>>());
        expect(result.length, 1);
        expect(result.first.id, 1);
        expect(result.first.title, 'Bug in navigation');
        expect(result.first.number, 123);
        verify(mockApi.getRepositoryIssues(owner, repo)).called(1);
        verifyNoMoreInteractions(mockApi);
      });

      test('should return empty list when API returns empty issues', () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        final mockApiResponse = TestData.apiIssuesEmptyResponse;

        when(mockApi.getRepositoryIssues(owner, repo))
            .thenAnswer((_) async => mockApiResponse);

        // Act
        final result = await repository.getRepositoryIssues(owner, repo);

        // Assert
        expect(result, isEmpty);
        verify(mockApi.getRepositoryIssues(owner, repo)).called(1);
        verifyNoMoreInteractions(mockApi);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        when(mockApi.getRepositoryIssues(owner, repo))
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => repository.getRepositoryIssues(owner, repo),
          throwsA(isA<Exception>()),
        );
        verify(mockApi.getRepositoryIssues(owner, repo)).called(1);
        verifyNoMoreInteractions(mockApi);
      });
    });

    group('getRepositoryPullRequests', () {
      test('should return list of pull requests when API call is successful',
          () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        final mockApiResponse = TestData.apiPullRequestsResponse;

        when(mockApi.getRepositoryPullRequests(owner, repo))
            .thenAnswer((_) async => mockApiResponse);

        // Act
        final result = await repository.getRepositoryPullRequests(owner, repo);

        // Assert
        expect(result, isA<List<PullRequestEntity>>());
        expect(result.length, 1);
        expect(result.first.id, 1);
        expect(result.first.title, 'Fix navigation bug');
        expect(result.first.number, 456);
        expect(result.first.isMerged, false);
        verify(mockApi.getRepositoryPullRequests(owner, repo)).called(1);
        verifyNoMoreInteractions(mockApi);
      });

      test('should return empty list when API returns empty pull requests',
          () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        final mockApiResponse = TestData.apiPullRequestsEmptyResponse;

        when(mockApi.getRepositoryPullRequests(owner, repo))
            .thenAnswer((_) async => mockApiResponse);

        // Act
        final result = await repository.getRepositoryPullRequests(owner, repo);

        // Assert
        expect(result, isEmpty);
        verify(mockApi.getRepositoryPullRequests(owner, repo)).called(1);
        verifyNoMoreInteractions(mockApi);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        when(mockApi.getRepositoryPullRequests(owner, repo))
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => repository.getRepositoryPullRequests(owner, repo),
          throwsA(isA<Exception>()),
        );
        verify(mockApi.getRepositoryPullRequests(owner, repo)).called(1);
        verifyNoMoreInteractions(mockApi);
      });

      test('should handle merged pull request correctly', () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        final mockApiResponse = TestData.apiPullRequestsMergedResponse;

        when(mockApi.getRepositoryPullRequests(owner, repo))
            .thenAnswer((_) async => mockApiResponse);

        // Act
        final result = await repository.getRepositoryPullRequests(owner, repo);

        // Assert
        expect(result, isA<List<PullRequestEntity>>());
        expect(result.length, 1);
        expect(result.first.isMerged, true);
        expect(result.first.mergedAt, isNotNull);
        verify(mockApi.getRepositoryPullRequests(owner, repo)).called(1);
        verifyNoMoreInteractions(mockApi);
      });
    });
  });
}
