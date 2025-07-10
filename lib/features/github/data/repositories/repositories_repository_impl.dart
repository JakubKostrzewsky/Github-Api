import 'package:github/features/github/data/api/github_api.dart';
import 'package:github/features/github/domain/entities/issue_entity.dart';
import 'package:github/features/github/domain/entities/pull_request_entity.dart';
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

  @override
  Future<List<IssueEntity>> getRepositoryIssues(
    String owner,
    String repo,
  ) async {
    try {
      final issuesData = await _api.getRepositoryIssues(owner, repo);
      return issuesData.map(IssueEntity.fromJson).toList();
    } catch (e) {
      throw Exception('Failed to get repository issues: $e');
    }
  }

  @override
  Future<List<PullRequestEntity>> getRepositoryPullRequests(
    String owner,
    String repo,
  ) async {
    try {
      final pullRequestsData =
          await _api.getRepositoryPullRequests(owner, repo);
      return pullRequestsData.map(PullRequestEntity.fromJson).toList();
    } catch (e) {
      throw Exception('Failed to get repository pull requests: $e');
    }
  }
}
