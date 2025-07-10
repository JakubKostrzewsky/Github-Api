import 'package:github/features/github/domain/entities/issue_entity.dart';
import 'package:github/features/github/domain/entities/pull_request_entity.dart';
import 'package:github/features/github/domain/entities/repository_details_entity.dart';
import 'package:github/features/github/domain/repositories/repositories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepositoryDetailsUseCase {
  const GetRepositoryDetailsUseCase(this._repository);

  final RepositoriesRepository _repository;

  Future<RepositoryDetailsEntity> call(
    String owner,
    String repo,
  ) async {
    final issuesFuture = _repository.getRepositoryIssues(owner, repo);
    final pullRequestsFuture = _repository.getRepositoryPullRequests(owner, repo);

    final results = await Future.wait([issuesFuture, pullRequestsFuture]);
    final issues = results[0] as List<IssueEntity>;
    final pullRequests = results[1] as List<PullRequestEntity>;

    return RepositoryDetailsEntity(
      issues: issues,
      pullRequests: pullRequests,
    );
  }
}
