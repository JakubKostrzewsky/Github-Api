import 'package:equatable/equatable.dart';
import 'package:github/features/github/domain/entities/issue_entity.dart';
import 'package:github/features/github/domain/entities/pull_request_entity.dart';

class RepositoryDetailsEntity extends Equatable {
  const RepositoryDetailsEntity({
    required this.issues,
    required this.pullRequests,
  });

  final List<IssueEntity> issues;
  final List<PullRequestEntity> pullRequests;

  @override
  List<Object?> get props => [issues, pullRequests];
}
