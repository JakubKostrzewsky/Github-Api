import 'package:github/features/github/domain/entities/repository_entity.dart';
import 'package:github/features/github/domain/repositories/repositories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRepositoriesUseCase {
  const GetRepositoriesUseCase(this._repository);

  final RepositoriesRepository _repository;

  Future<List<RepositoryEntity>> call(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    return _repository.searchRepositories(query.trim());
  }
}
