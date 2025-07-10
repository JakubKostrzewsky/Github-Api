import 'package:equatable/equatable.dart';
import 'package:github/features/github/domain/entities/repository_entity.dart';

sealed class RepositoriesState extends Equatable {
  const RepositoriesState();

  @override
  List<Object?> get props => [];
}

class RepositoriesInitial extends RepositoriesState {
  const RepositoriesInitial();
}

class RepositoriesLoading extends RepositoriesState {
  const RepositoriesLoading();
}

class RepositoriesLoaded extends RepositoriesState {
  const RepositoriesLoaded({
    required this.repositories,
    required this.query,
  });

  final List<RepositoryEntity> repositories;
  final String query;

  @override
  List<Object?> get props => [repositories, query];
}

class RepositoriesError extends RepositoriesState {
  const RepositoriesError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
