import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class GitHubApi {
  GitHubApi(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> searchRepositories(String query) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/search/repositories',
        queryParameters: {
          'q': query,
          'sort': 'stars',
          'order': 'desc',
          'per_page': 30,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('Failed to search repositories: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getRepositoryIssues(
    String owner,
    String repo,
  ) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/repos/$owner/$repo/issues',
        queryParameters: {
          'state': 'all',
          'per_page': 30,
        },
      );

      return (response.data as List).cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw Exception('Failed to fetch issues: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getRepositoryPullRequests(
    String owner,
    String repo,
  ) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/repos/$owner/$repo/pulls',
        queryParameters: {
          'state': 'all',
          'per_page': 30,
        },
      );

      return (response.data as List).cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw Exception('Failed to fetch pull requests: ${e.message}');
    }
  }
}
