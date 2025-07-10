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
}
