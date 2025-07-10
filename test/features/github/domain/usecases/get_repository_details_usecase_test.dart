import 'package:flutter_test/flutter_test.dart';
import 'package:github/features/github/domain/entities/repository_details_entity.dart';
import 'package:github/features/github/domain/repositories/repositories_repository.dart';
import 'package:github/features/github/domain/usecases/get_repository_details_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../mocks/test_data.dart';

import 'get_repository_details_usecase_test.mocks.dart';

@GenerateMocks([RepositoriesRepository])
void main() {
  late GetRepositoryDetailsUseCase useCase;
  late MockRepositoriesRepository mockRepository;

  setUp(() {
    mockRepository = MockRepositoriesRepository();
    useCase = GetRepositoryDetailsUseCase(mockRepository);
  });

  test('returns details with issues and pull requests', () async {
    const owner = 'flutter';
    const repo = 'flutter';
    final issues = TestData.issues;
    final prs = TestData.pullRequests;

    when(mockRepository.getRepositoryIssues(owner, repo))
        .thenAnswer((_) async => issues);
    when(mockRepository.getRepositoryPullRequests(owner, repo))
        .thenAnswer((_) async => prs);

    final result = await useCase(owner, repo);

    expect(result, isA<RepositoryDetailsEntity>());
    expect(result.issues, issues);
    expect(result.pullRequests, prs);
    verify(mockRepository.getRepositoryIssues(owner, repo)).called(1);
    verify(mockRepository.getRepositoryPullRequests(owner, repo)).called(1);
  });

  test('throws when issues call fails', () async {
    when(mockRepository.getRepositoryIssues(any, any))
        .thenThrow(Exception('error'));
    when(mockRepository.getRepositoryPullRequests(any, any))
        .thenAnswer((_) async => []);

    expect(() => useCase('a', 'b'), throwsException);
  });

  test('throws when pull requests call fails', () async {
    when(mockRepository.getRepositoryIssues(any, any))
        .thenAnswer((_) async => []);
    when(mockRepository.getRepositoryPullRequests(any, any))
        .thenThrow(Exception('error'));

    expect(() => useCase('a', 'b'), throwsException);
  });
}
