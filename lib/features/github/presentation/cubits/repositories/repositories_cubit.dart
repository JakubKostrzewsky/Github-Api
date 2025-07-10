import 'package:bloc/bloc.dart';
import 'package:github/features/github/domain/usecases/get_repositories_usecase.dart';
import 'package:github/features/github/presentation/cubits/repositories/repositories_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class RepositoriesCubit extends Cubit<RepositoriesState> {
  RepositoriesCubit(this._getRepositoriesUseCase)
      : super(const RepositoriesInitial());

  final GetRepositoriesUseCase _getRepositoriesUseCase;

  Future<void> searchRepositories(String query) async {
    if (query.trim().isEmpty) {
      emit(const RepositoriesInitial());
      return;
    }
    emit(const RepositoriesLoading());
    try {
      final repositories = await _getRepositoriesUseCase(query);
      emit(RepositoriesLoaded(repositories: repositories, query: query));
    } catch (e) {
      emit(RepositoriesError(e.toString()));
    }
  }
}
