import 'package:dio/dio.dart';
import 'package:github/features/github/domain/entities/issue_entity.dart';
import 'package:github/features/github/domain/entities/pull_request_entity.dart';
import 'package:github/features/github/domain/entities/repository_details_entity.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';

class TestData {
  // Repository test data
  static final List<RepositoryEntity> repositories = [
    RepositoryEntity(
      id: 1,
      name: 'flutter',
      fullName: 'flutter/flutter',
      description: 'Flutter framework',
      owner: 'flutter',
      ownerAvatarUrl: 'https://example.com/avatar.png',
      language: 'Dart',
      stars: 1000,
      forks: 500,
      watchers: 200,
      htmlUrl: 'https://github.com/flutter/flutter',
      createdAt: DateTime(2020),
      updatedAt: DateTime(2024),
    ),
    RepositoryEntity(
      id: 2,
      name: 'dart',
      fullName: 'dart-lang/dart',
      description: 'Dart programming language',
      owner: 'dart-lang',
      ownerAvatarUrl: 'https://example.com/dart-avatar.png',
      language: 'Dart',
      stars: 800,
      forks: 300,
      watchers: 150,
      htmlUrl: 'https://github.com/dart-lang/dart',
      createdAt: DateTime(2019),
      updatedAt: DateTime(2024),
    ),
  ];

  // Issues test data
  static final List<IssueEntity> issues = [
    IssueEntity(
      id: 1,
      title: 'Bug in navigation',
      number: 123,
      body: 'There is a bug in the navigation system',
      state: 'open',
      user: 'developer1',
      userAvatarUrl: 'https://example.com/user1.png',
      createdAt: DateTime(2024, 1),
      updatedAt: DateTime(2024, 1, 2),
      htmlUrl: 'https://github.com/flutter/flutter/issues/123',
    ),
    IssueEntity(
      id: 2,
      title: 'Feature request: dark mode',
      number: 124,
      body: 'Please add dark mode support',
      state: 'open',
      user: 'developer2',
      userAvatarUrl: 'https://example.com/user2.png',
      createdAt: DateTime(2024, 1, 3),
      updatedAt: DateTime(2024, 1, 4),
      htmlUrl: 'https://github.com/flutter/flutter/issues/124',
    ),
  ];

  // Pull Requests test data
  static final List<PullRequestEntity> pullRequests = [
    PullRequestEntity(
      id: 1,
      title: 'Fix navigation bug',
      number: 456,
      body: 'This PR fixes the navigation bug',
      state: 'open',
      user: 'developer1',
      userAvatarUrl: 'https://example.com/user1.png',
      createdAt: DateTime(2024, 1),
      updatedAt: DateTime(2024, 1, 2),
      htmlUrl: 'https://github.com/flutter/flutter/pull/456',
      mergedAt: null,
      isMerged: false,
    ),
    PullRequestEntity(
      id: 2,
      title: 'Add dark mode support',
      number: 457,
      body: 'This PR adds dark mode support',
      state: 'open',
      user: 'developer2',
      userAvatarUrl: 'https://example.com/user2.png',
      createdAt: DateTime(2024, 1, 3),
      updatedAt: DateTime(2024, 1, 4),
      htmlUrl: 'https://github.com/flutter/flutter/pull/457',
      mergedAt: null,
      isMerged: false,
    ),
  ];

  // Repository Details test data
  static final RepositoryDetailsEntity repositoryDetails =
      RepositoryDetailsEntity(
    issues: issues,
    pullRequests: pullRequests,
  );

  // Error messages
  static const String mockErrorMessage = 'Network error occurred';
  static const String mockExceptionMessage = 'Failed to fetch data';

  // API mock responses
  static final Map<String, dynamic> apiRepositoriesResponse = {
    'items': [
      {
        'id': 1,
        'name': 'flutter',
        'full_name': 'flutter/flutter',
        'description': 'Flutter framework',
        'owner': {
          'login': 'flutter',
          'avatar_url': 'https://example.com/avatar.png',
        },
        'language': 'Dart',
        'stargazers_count': 1000,
        'forks_count': 500,
        'watchers_count': 200,
        'html_url': 'https://github.com/flutter/flutter',
        'created_at': '2020-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      }
    ],
  };

  static final Map<String, dynamic> apiRepositoriesEmptyResponse = {
    'items': [],
  };

  static final Map<String, dynamic> apiRepositoriesMalformedResponse = {
    'items': null,
  };

  static final List<Map<String, dynamic>> apiIssuesResponse = [
    {
      'id': 1,
      'number': 123,
      'title': 'Bug in navigation',
      'body': 'There is a bug in the navigation system',
      'state': 'open',
      'user': {
        'login': 'developer1',
        'avatar_url': 'https://example.com/user1.png',
      },
      'created_at': '2024-01-01T00:00:00Z',
      'updated_at': '2024-01-02T00:00:00Z',
      'html_url': 'https://github.com/flutter/flutter/issues/123',
    }
  ];

  static final List<Map<String, dynamic>> apiIssuesEmptyResponse = [];

  static final List<Map<String, dynamic>> apiPullRequestsResponse = [
    {
      'id': 1,
      'number': 456,
      'title': 'Fix navigation bug',
      'body': 'This PR fixes the navigation bug',
      'state': 'open',
      'user': {
        'login': 'developer1',
        'avatar_url': 'https://example.com/user1.png',
      },
      'created_at': '2024-01-01T00:00:00Z',
      'updated_at': '2024-01-02T00:00:00Z',
      'html_url': 'https://github.com/flutter/flutter/pull/456',
      'merged_at': null,
      'merged': false,
    }
  ];

  static final List<Map<String, dynamic>> apiPullRequestsEmptyResponse = [];

  static final List<Map<String, dynamic>> apiPullRequestsMergedResponse = [
    {
      'id': 1,
      'number': 456,
      'title': 'Fix navigation bug',
      'body': 'This PR fixes the navigation bug',
      'state': 'closed',
      'user': {
        'login': 'developer1',
        'avatar_url': 'https://example.com/user1.png',
      },
      'created_at': '2024-01-01T00:00:00Z',
      'updated_at': '2024-01-02T00:00:00Z',
      'html_url': 'https://github.com/flutter/flutter/pull/456',
      'merged_at': '2024-01-03T00:00:00Z',
      'merged': true,
    }
  ];

  // Dio Response mocks for API tests
  static final Response<Map<String, dynamic>> apiSearchRepositoriesDioResponse =
      Response<Map<String, dynamic>>(
    data: apiRepositoriesResponse,
    statusCode: 200,
    requestOptions: RequestOptions(),
  );

  static final Response<Map<String, dynamic>>
      apiSearchRepositoriesErrorDioResponse = Response<Map<String, dynamic>>(
    statusCode: 404,
    requestOptions: RequestOptions(),
  );

  static final Response<List<dynamic>> apiIssuesDioResponse =
      Response<List<dynamic>>(
    data: apiIssuesResponse,
    statusCode: 200,
    requestOptions: RequestOptions(),
  );

  static final Response<List<dynamic>> apiIssuesEmptyDioResponse =
      Response<List<dynamic>>(
    data: apiIssuesEmptyResponse,
    statusCode: 200,
    requestOptions: RequestOptions(),
  );

  static final Response<List<dynamic>> apiPullRequestsDioResponse =
      Response<List<dynamic>>(
    data: apiPullRequestsResponse,
    statusCode: 200,
    requestOptions: RequestOptions(),
  );

  static final Response<List<dynamic>> apiPullRequestsEmptyDioResponse =
      Response<List<dynamic>>(
    data: apiPullRequestsEmptyResponse,
    statusCode: 200,
    requestOptions: RequestOptions(),
  );

  static final Response<List<dynamic>> apiPullRequestsMergedDioResponse =
      Response<List<dynamic>>(
    data: apiPullRequestsMergedResponse,
    statusCode: 200,
    requestOptions: RequestOptions(),
  );
}
