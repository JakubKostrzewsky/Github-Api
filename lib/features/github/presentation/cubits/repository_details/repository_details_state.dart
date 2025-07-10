import 'package:equatable/equatable.dart';
import 'package:github/features/github/domain/entities/repository_details_entity.dart';

sealed class RepositoryDetailsState extends Equatable {
  const RepositoryDetailsState();

  @override
  List<Object?> get props => [];
}

class RepositoryDetailsLoading extends RepositoryDetailsState {
  const RepositoryDetailsLoading();
}

class RepositoryDetailsLoaded extends RepositoryDetailsState {
  const RepositoryDetailsLoaded(this.details);

  final RepositoryDetailsEntity details;

  @override
  List<Object?> get props => [details];
}

class RepositoryDetailsError extends RepositoryDetailsState {
  const RepositoryDetailsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
