import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github/features/github/data/api/github_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/test_data.dart';
import 'github_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('GitHubApi', () {
    late GitHubApi api;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      api = GitHubApi(mockDio);
    });

    group('searchRepositories', () {
      test('should return repositories data when API call is successful',
          () async {
        // Arrange
        const query = 'flutter';
        final mockResponse = TestData.apiSearchRepositoriesDioResponse;

        when(mockDio.get<Map<String, dynamic>>(
          'https://api.github.com/search/repositories',
          queryParameters: {
            'q': query,
            'sort': 'stars',
            'order': 'desc',
            'per_page': 30,
          },
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await api.searchRepositories(query);

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['items'], isA<List>());
        expect((result['items'] as List).length, 1);
        verify(mockDio.get<Map<String, dynamic>>(
          'https://api.github.com/search/repositories',
          queryParameters: {
            'q': query,
            'sort': 'stars',
            'order': 'desc',
            'per_page': 30,
          },
        )).called(1);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const query = 'flutter';
        when(mockDio.get<Map<String, dynamic>>(
          any,
          queryParameters: anyNamed('queryParameters'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: ''),
          response: TestData.apiSearchRepositoriesErrorDioResponse,
        ));

        // Act & Assert
        expect(
          () => api.searchRepositories(query),
          throwsA(isA<Exception>()),
        );
        verify(mockDio.get<Map<String, dynamic>>(
          'https://api.github.com/search/repositories',
          queryParameters: {
            'q': query,
            'sort': 'stars',
            'order': 'desc',
            'per_page': 30,
          },
        )).called(1);
      });
    });

    group('getRepositoryIssues', () {
      test('should return issues data when API call is successful', () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        final mockResponse = TestData.apiIssuesDioResponse;

        when(mockDio.get<List<dynamic>>(
          'https://api.github.com/repos/$owner/$repo/issues',
          queryParameters: {
            'state': 'open',
            'per_page': 30,
          },
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await api.getRepositoryIssues(owner, repo);

        // Assert
        expect(result, isA<List<Map<String, dynamic>>>());
        expect(result.length, 1);
        expect(result.first['id'], 1);
        expect(result.first['title'], 'Bug in navigation');
        verify(mockDio.get<List<dynamic>>(
          'https://api.github.com/repos/$owner/$repo/issues',
          queryParameters: {
            'state': 'open',
            'per_page': 30,
          },
        )).called(1);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        when(mockDio.get<List<dynamic>>(
          any,
          queryParameters: anyNamed('queryParameters'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: ''),
          response: TestData.apiSearchRepositoriesErrorDioResponse,
        ));

        // Act & Assert
        expect(
          () => api.getRepositoryIssues(owner, repo),
          throwsA(isA<Exception>()),
        );
        verify(mockDio.get<List<dynamic>>(
          'https://api.github.com/repos/$owner/$repo/issues',
          queryParameters: {
            'state': 'open',
            'per_page': 30,
          },
        )).called(1);
      });
    });

    group('getRepositoryPullRequests', () {
      test('should return pull requests data when API call is successful',
          () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        final mockResponse = TestData.apiPullRequestsDioResponse;

        when(mockDio.get<List<dynamic>>(
          'https://api.github.com/repos/$owner/$repo/pulls',
          queryParameters: {
            'state': 'open',
            'per_page': 30,
          },
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await api.getRepositoryPullRequests(owner, repo);

        // Assert
        expect(result, isA<List<Map<String, dynamic>>>());
        expect(result.length, 1);
        expect(result.first['id'], 1);
        expect(result.first['title'], 'Fix navigation bug');
        verify(mockDio.get<List<dynamic>>(
          'https://api.github.com/repos/$owner/$repo/pulls',
          queryParameters: {
            'state': 'open',
            'per_page': 30,
          },
        )).called(1);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        const owner = 'flutter';
        const repo = 'flutter';
        when(mockDio.get<List<dynamic>>(
          any,
          queryParameters: anyNamed('queryParameters'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: ''),
          response: TestData.apiSearchRepositoriesErrorDioResponse,
        ));

        // Act & Assert
        expect(
          () => api.getRepositoryPullRequests(owner, repo),
          throwsA(isA<Exception>()),
        );
        verify(mockDio.get<List<dynamic>>(
          'https://api.github.com/repos/$owner/$repo/pulls',
          queryParameters: {
            'state': 'open',
            'per_page': 30,
          },
        )).called(1);
      });
    });
  });
}
