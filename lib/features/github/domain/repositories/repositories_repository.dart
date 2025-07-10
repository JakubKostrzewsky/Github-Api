import 'package:github/features/github/domain/entities/repository_entity.dart';

abstract class RepositoriesRepository {
  Future<List<RepositoryEntity>> searchRepositories(String query);
}
