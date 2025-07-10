import 'package:github/features/github/domain/entities/issue_entity.dart';
import 'package:github/features/github/domain/entities/pull_request_entity.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';

abstract class RepositoriesRepository {
  Future<List<RepositoryEntity>> searchRepositories(String query);

  Future<List<IssueEntity>> getRepositoryIssues(
    String owner,
    String repo,
  );

  Future<List<PullRequestEntity>> getRepositoryPullRequests(
    String owner,
    String repo,
  );
}
