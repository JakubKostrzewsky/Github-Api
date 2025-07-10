import 'package:github/features/github/data/api/github_api.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';
import 'package:github/features/github/domain/repositories/repositories_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RepositoriesRepository)
class RepositoriesRepositoryImpl implements RepositoriesRepository {
  const RepositoriesRepositoryImpl(this._api);
  final GitHubApi _api;

  @override
  Future<List<RepositoryEntity>> searchRepositories(String query) async {
    try {
      final response = await _api.searchRepositories(query);
      final items = response['items'] as List<dynamic>;

      return items
          .map(
            (item) => RepositoryEntity.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to search repositories: $e');
    }
  }
}
